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
    ///coords[0] is point of first corner. coords[1] is center
    coords: [2]Vector2f,
    speed: f32,
    energy: u32,
    rotated: f32 = 0.0,
    const rotate_speed: f32 = (m.pi / 120.0);

    pub fn rotateCell(self: *Cell, clockwise: bool) void {
        const delta_rs = if (clockwise) -rotate_speed else rotate_speed;
        self.rotated += delta_rs;
        self.coords[0] = g.rotate(self.coords[0], self.coords[1], delta_rs);
    }
    pub fn moveCell(self: *Cell) void {
        const delta = g.stv(self.rotated, self.speed);
        var i: u8 = 0;
        while (i < 2) : (i += 1) {
            self.coords[i] = self.coords[i].add(delta);
        }
    }
    pub fn divisionCell(self: *Cell) Cell {
        self.energy -= 20;
        self.energy /= 2;
        self.coords[0] = Vector2f.add(self.coords[0], g.stv((self.rotated + m.pi / 2.0), -0.5));
        self.coords[1] = Vector2f.add(self.coords[1], g.stv((self.rotated + m.pi / 2.0), -0.5));
        return .{ .type_c = self.type_c, .coords = .{ Vector2f.add(self.coords[0], g.stv(self.rotated, 1)), Vector2f.add(self.coords[1], g.stv(self.rotated, 1)) }, .speed = self.speed, .energy = self.energy, .rotated = self.rotated };
    }
    pub fn init(coord: Vector2f, type_cell: TypeCell) Cell {
        const temp_speed: f32 = if (type_cell == TypeCell.moving) (1 / 60) else (1 / 120);
        return .{ .type_c = type_cell, .coords = .{ coord, coord.add(.{ .x = 0.5, .y = 0.5 }) }, .speed = temp_speed, .energy = 100 };
    }
};

///And this one describes a multicellar organism... The struct isn't done so far
const Multicellular = struct {};

test "init a cell" {
    const cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    print("\ncoords[0].x: {}\ncoords[1].y: {}\ntype_c: {}\n", .{ cell.coords[0].x, cell.coords[1].y, cell.type_c });
    try expect(cell.coords[0].x == 1);
    try expect(cell.coords[1].y == 1.5);
    try expect(cell.type_c == TypeCell.moving);
}

test "moveCell" {
    var cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    var i: u8 = 0;
    while (i < 60) : (i += 1) {
        cell.moveCell();
    }
    try expect(cell.coords[0].x > 0.9);
    try expect(cell.coords[0].x < 1.1);
    print("\ncell.coords[0].x: {}\n", .{cell.coords[0].x});
}

test "rotateCell" {
    var cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    var i: u8 = 0;
    while (i < 60) : (i += 1) {
        cell.rotateCell(true);
    }
    print("coords[0]: x:{}, y:{}\ncoords[1]: x:{}, y:{}\n", .{ cell.coords[0].x, cell.coords[0].y, cell.coords[1].x, cell.coords[1].y });
    print("rotated: {}\n", .{cell.rotated});
}

test "divisionCell" {
    var cell: Cell = Cell.init(.{ .x = 1, .y = 1 }, TypeCell.moving);
    var cell2: Cell = cell.divisionCell();
    print("coords[0]: .x:{}, .y:{}\n", .{ cell2.coords[0].x, cell2.coords[0].y });
    print("coords[1]: .x:{}, .y:{}\n", .{ cell2.coords[1].x, cell2.coords[1].y });
}
