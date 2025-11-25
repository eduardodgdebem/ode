#include <filesystem>

class Linker {
public:
    explicit Linker(std::filesystem::path op);

    void link(const std::filesystem::path& executablePath);

private:
    std::filesystem::path objectPath;
};

