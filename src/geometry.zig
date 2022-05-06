//Copyright 2022 Smagin Mikhail
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

//!This file describes geometry logic
//!such as rotating and equating two Vector2's
const std = @import("std");
const m = std.math;
const sf = @import("sfml");
const print = std.debug.print;
const Vector2f = sf.system.Vector2f;
const sin = m.sin;
const cos = m.cos;

///rotates first point(v2f) around second(c) one by rad radians
pub fn rotate(v2f: Vector2f, c: Vector2f, rad: f32) Vector2f {
    return Vector2f{
        .x = (c.x + (v2f.x - c.x) * cos(rad) - (v2f.y - c.y) * sin(rad)),
        .y = (c.y + (v2f.x - c.x) * sin(rad) + (v2f.y - c.y) * cos(rad)),
    };
}

///convert scalar value into vector one using known angle.
pub fn scalarToVector(rad: f32, scalar: f32) Vector2f {
    return .{
        .x = cos(rad) * scalar,
        .y = sin(rad) * scalar,
    };
}

test "rotate" {
    var a = Vector2f{ .x = 0, .y = 1 };
    a = rotate(a, .{ .x = 0, .y = 0 }, m.pi / 2.0);
    print("\na.x: {}\na.y: {}\n", .{ a.x, a.y });
}
