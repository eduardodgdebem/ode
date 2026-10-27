// The C side of tests/abi/abi.ode: a function giving and one taking each
// shape of struct, by value, as C passes them on the target it is built for.
#include "shapes.h"
Color give_Color(void) { return (Color){1, 2, 3, 4}; }
Color take_Color(Color c) { return (Color){c.r + 1, c.g + 1, c.b + 1, c.a + 1}; }
Vec2 give_Vec2(void) { return (Vec2){1.5f, 2.5f}; }
Vec2 take_Vec2(Vec2 v) { return (Vec2){v.x * 2, v.y * 2}; }
Rect give_Rect(void) { return (Rect){1, 2, 3, 4}; }
Rect take_Rect(Rect r) { return (Rect){r.w, r.h, r.x, r.y}; }
D2 give_D2(void) { return (D2){0.25, 0.5}; }
D2 take_D2(D2 d) { return (D2){d.y, d.x}; }
Mixed give_Mixed(void) { return (Mixed){7, 0.5f}; }
Mixed take_Mixed(Mixed m) { return (Mixed){m.a * 2, m.b * 2}; }
I3 give_I3(void) { return (I3){10, 20, 30}; }
I3 take_I3(I3 i) { return (I3){i.c, i.b, i.a}; }
LD give_LD(void) { return (LD){-5, 1.25}; }
LD take_LD(LD l) { return (LD){l.a * 3, l.b * 3}; }
Big give_Big(void) { return (Big){100, 200, 300}; }
Big take_Big(Big b) { return (Big){b.c, b.a, b.b}; }
Vec3 give_Vec3(void) { return (Vec3){1, 2, 3}; }
Vec3 take_Vec3(Vec3 v) { return (Vec3){v.z, v.y, v.x}; }
One give_One(void) { return (One){42}; }
One take_One(One o) { return (One){o.one + 1}; }
OneD give_OneD(void) { return (OneD){2.5}; }
OneD take_OneD(OneD o) { return (OneD){o.d * 4}; }
double mix(int32_t a, Vec2 v, double d, Rect r, Big b, Color c, Vec3 v3, LD l) {
  return a + v.x + v.y + d + r.x + r.y + r.w + r.h + b.a + b.b + b.c + c.r + c.g + c.b + c.a +
         v3.x + v3.y + v3.z + l.a + l.b;
}
