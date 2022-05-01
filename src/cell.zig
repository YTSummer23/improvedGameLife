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

const std = @import("std");
const m = std.math;
const g = struct {
    usingnamespace @import("geometry.zig");
    const stv = g.scalarToVector;
};
const sf = @import("sfml");
const Vector2f = sf.system.Vector2f;
const expect = std.testing.expect;
const print = std.debug.print;

///Types of cell
const TypeCell = enum { moving, transfering, sharp, bone };

///This struct describes a cell...
const Cell = struct {
    type_c: TypeCell,
    coords: [4]Vector2f,
    speed: f32,
    rotated: f32 = 0.0,
    energy: u32,
    const rotate_speed: f32 = (m.pi / 120.0);

    pub fn rotateCell(self: *Cell, clockwise: bool) void {
        const cx = m.fabs(self.coords[0].x - self.coords[2].x);
        const cy = m.fabs(self.coords[0].y - self.coords[2].y);
        const c = Vector2f{ .x = cx, .y = cy };
        var i: u8 = 0;
        const delta_rs = if (clockwise) -rotate_speed else rotate_speed;
        self.rotated += delta_rs;
        while (i < 4) : (i += 1) {
            g.equate(&self.coords[i], g.rotate(self.coords[i], c, delta_rs));
        }
    }
    pub fn moveCell(self: *Cell) void {
        var i: u8 = 0;
        const delta = g.stv(self.rotated, self.speed);
        while (i < 4) : (i += 1) {
            g.equate(&self.coords[i], self.coords[i].add(delta));
        }
    }
    pub fn init(coord: Vector2f, type_cell: TypeCell) Cell {
        const a_speed: f32 = switch (type_cell) {
            TypeCell.moving => (1.0 / 60.0),
            else => 0.0,
        };
        return .{ .type_c = type_cell, .coords = .{ .{ .x = coord.x, .y = coord.y }, .{ .x = coord.x + 1.0, .y = coord.y }, .{ .x = coord.x + 1.0, .y = coord.y + 1.0 }, .{ .x = coord.x, .y = coord.y + 1.0 } }, .speed = a_speed, .energy = 1000 };
    }
};

///And this one describes a multicellar organism... The struct isn't done so far
const Multicellular = struct {};

test "init a cell" {
    const cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    try expect(cell.coords[0].x == 1);
    try expect(cell.coords[2].y == 2);
    try expect(cell.type_c == TypeCell.moving);
    print("\ncoords[1].x: {}\ncoords[2].y: {}\ntype_c: {}\n", .{ cell.coords[1].x, cell.coords[2].y, cell.type_c });
}

test "moveCell" {
    var cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    var i: u8 = 0;
    while (i < 60) : (i += 1) {
        cell.moveCell();
    }
    try expect(cell.coords[0].x > 1.9);
    try expect(cell.coords[0].x < 2.1);
    print("\ncell.coords[0].x: {}\n", .{cell.coords[0].x});
}
