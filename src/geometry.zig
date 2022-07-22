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
const print = std.debug.print;
const sin = m.sin;
const cos = m.cos;

pub const Vector2f = struct {
    x: f64,
    y: f64,
    pub fn add(self: Vector2f, other: Vector2f) Vector2f {
        return .{ .x = self.x + other.x, .y = self.y + other.y };
    }
    pub fn scale(self: Vector2f, scalar: f64) Vector2f {
        return .{ .x = self.x * scalar, .y = self.y * scalar };
    }
};

///rotates first point(v2f) around second(c) one by rad radians
pub fn rotate(v2f: Vector2f, c: Vector2f, rad: f64) Vector2f {
    return Vector2f{
        .x = (c.x + (v2f.x - c.x) * cos(rad) - (v2f.y - c.y) * sin(rad)),
        .y = (c.y + (v2f.x - c.x) * sin(rad) + (v2f.y - c.y) * cos(rad)),
    };
}

///convert scalar value into vector one using known angle.
pub fn scalarToVector(rad: f64, scalar: f64) Vector2f {
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
