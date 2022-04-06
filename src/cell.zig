const std = @import("std");
const m = std.math;
const g = geometry.zig;
const sf = @import("sfml");
const Vectorf2 = sf.Vector2f;

TypeCell = enum {
    moving,
    transfering,
    sharp,
    bone,
};

Cell = struct {
    typeC: TypeCell,
    coords: [4]Vector2f,

    pub fn rotateCell(self: *Cell, rad: f32) void {
        const cx = m.fabs(self.coords[0].x - self.coords[2].x);
        const cy = m.fabs(self.coords[0].y - self.coords[2].y);
        const c = Vector2f { .x = cx, .y = cy };
        var i: u8 = 0;
        while (i < 10) : (i += 1) {
            g.equateV2f(g.rotate(self.coords[i], c, rad), self.coords[i]);
        }
    }
};

Multicellular = struct {

};
