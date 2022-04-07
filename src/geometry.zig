//!This file describes geometry logic
//!Such as rotating and equating two Vector2's
const std = @import("std");
const m = std.math;
const sf = @import("sfml");
const print = std.debug.print;
const Vector2f = sf.system.Vector2f;
const sin = m.sin; const cos = m.cos;

///rotates first point(v2f) around second(c) one by rad radians
pub fn rotate(v2f: Vector2f, c: Vector2f, rad: f32) Vector2f {
    return Vector2f {
        .x = (c.x + (v2f.x - c.x) * cos(rad) - (v2f.y - c.y) * sin(rad)),
        .y = (c.y + (v2f.x - c.x) * sin(rad) + (v2f.y - c.y) * cos(rad)),
    };
}

///equates two Vector2's
pub fn equate(v2f1: *Vector2f, v2f2: Vector2f) void {
    v2f1.*.x = v2f2.x;
    v2f1.*.y = v2f2.y; 
}

test "equate" {
    var a = Vector2f {
        .x = 0,
        .y = 0.5
    };
    const b = Vector2f {
        .x = 2,
        .y = 2
    };
    equate(&a, b);
    print("\na.x: {}\na.y: {}\n", .{a.x, a.y});
}

test "rotate" {
    var a = Vector2f {
        .x = 0,
        .y = 1
    };
    equate(&a, rotate(a, .{.x=0, .y=0}, m.pi / @as(f32, 2)));
    print("\na.x: {}\na.y: {}\n", .{a.x, a.y});
}
