const std = @import("std");
const m = std.math;
const sf = @import("sfml");
const print = std.debug.print;
const Vector2f = sf.system.Vector2f;
const sin = m.sin; const cos = m.cos;

pub fn rotate(v2f: Vector2f, c: Vector2f, rad: f32) Vector2f {
    return Vector2f {
        .x = (v2f.x + (c.x + v2f.x) * cos(rad) - (c.x + v2f.x) * sin(rad)),
        .y = (v2f.y + (c.y + v2f.y) * sin(rad) + (c.y - v2f.y) * cos(rad)),
        };
}

pub fn equate(v2f1: *Vector2f, v2f2: Vector2f) void {
    v2f1.*.x = v2f2.x;
    v2f1.*.y = v2f2.y; 
}

test "rotate" {
    var a = Vector2f {
        .x = 0,
        .y = 1
    };
    equate(&a, rotate(a, .{.x=0, .y=0}, m.pi));
    print("a.x: {}\na.y: {}\n", .{a.x, a.y});
}
