const std = @import("std");
const sf = @import("sfml");
pub const g = @import("geometry.zig");

pub fn main() !void {
    const a: g = undefined;
    _ = a;
    _ = g.rotate(.{.x=1, .y=1}, .{.x=0, .y=0}, 3.14);
}
