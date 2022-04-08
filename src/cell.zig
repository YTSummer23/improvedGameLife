const std = @import("std");
const m = std.math;
const g = @import("geometry.zig");
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

    pub fn rotateCell(self: *Cell, rad: f32) void {
        const cx = m.fabs(self.coords[0].x - self.coords[2].x);
        const cy = m.fabs(self.coords[0].y - self.coords[2].y);
        const c = Vector2f{ .x = cx, .y = cy };
        var i: u8 = 0;
        while (i < 4) : (i += 1) {
            g.equate(&self.coords[i], g.rotate(self.coords[i], c, rad));
        }
    }
    pub fn moveCell(self: *Cell, delta: Vector2f) void {
        var i: u8 = 0;
        while (i < 4) : (i += 1) {
            g.equate(&self.coords[i], self.coords[i].add(delta));
        }
    }
    pub fn init(coord: Vector2f, type_cell: TypeCell) Cell {
        const one = @as(f32, 1);
        return .{ .type_c = type_cell, .coords = .{ .{ .x = coord.x, .y = coord.y }, .{ .x = coord.x + one, .y = coord.y }, .{ .x = coord.x + one, .y = coord.y + one }, .{ .x = coord.x, .y = coord.y + one } } };
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
    cell.moveCell(.{ .x = 1, .y = 1 });
    try expect(cell.coords[0].x == @as(f32, 2));
    print("\ncell.coords[0].x: {}\n", .{cell.coords[0].x});
}
