// Struct shapes that each target passes differently across the C ABI:
// bytes, floats alone (an HFA on arm64), mixed, 9-16 bytes, past 16, one field.
#include <stdint.h>
typedef struct { uint8_t r, g, b, a; } Color;
typedef struct { float x, y; } Vec2;
typedef struct { float x, y, w, h; } Rect;
typedef struct { double x, y; } D2;
typedef struct { int32_t a; float b; } Mixed;
typedef struct { int32_t a, b, c; } I3;
typedef struct { int64_t a; double b; } LD;
typedef struct { int64_t a, b, c; } Big;
typedef struct { float x, y, z; } Vec3;
typedef struct { int32_t one; } One;
typedef struct { double d; } OneD;
