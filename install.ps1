# Installs Ode on Windows, in WSL.
#
#   .\install.ps1                    build Ode and install it in WSL, under ~/.local
#   .\install.ps1 --prefix /usr/local, --debug, uninstall, --check, ...
#                                    whatever install.sh takes, handed to it
#
# Ode's compiler and the programs it builds are POSIX ones -- they fork, and
# link against a C library Windows does not have -- so on Windows they run
# in WSL, where Ode builds for and runs on Linux. This runs install.sh there,
# in this checkout; afterwards `wsl ode file.ode` builds a program from
# PowerShell, and `ode` does from a WSL shell.
#
# WSL reads a checkout on a Windows drive slowly. For more than trying Ode
# out, clone it inside WSL instead, and run ./install.sh there.

$ErrorActionPreference = 'Stop'

# WSL is always in System32 once it is installed, so it is looked for there
# rather than wherever the PATH happens to lead.
$wsl = if ($env:SystemRoot) { Join-Path $env:SystemRoot 'System32\wsl.exe' } else { $null }
if (-not $wsl -or -not (Test-Path $wsl)) {
  Write-Host "install: Ode runs on Windows through WSL, which is not installed."
  Write-Host "  wsl --install        from an administrator PowerShell, then restart, then run this again"
  exit 1
}

# WSL is there, but it may have no Linux in it yet.
& $wsl --exec true 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "install: WSL has no Linux distribution yet."
  Write-Host "  wsl --install -d Ubuntu     then open it once to finish setting it up, then run this again"
  exit 1
}

# The tools install.sh needs, installed from inside WSL if they are missing.
& $wsl --cd "$PSScriptRoot" --exec bash ./install.sh --check
if ($LASTEXITCODE -ne 0) {
  Write-Host ""
  Write-Host "install: WSL's Linux is missing tools Ode needs. In Ubuntu, for example:"
  Write-Host "  wsl sudo apt-get install clang lld llvm"
  exit 1
}

& $wsl --cd "$PSScriptRoot" --exec bash ./install.sh @args
exit $LASTEXITCODE
