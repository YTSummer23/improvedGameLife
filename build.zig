const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("theGame", "src/main.zig");
    exe.linkLibC();
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.emit_docs = .emit;
    exe.install();

    const run_step = b.step("run", "Run the game");
    run_step.dependOn(&exe.run().step);

    const test_geometry = b.addTest("src/geometry.zig");
    const test_geometry_step = b.step("test-geometry", "Tests geometry.zig file");
    test_geometry_step.dependOn(&test_geometry.step);

    const test_cell = b.addTest("src/cell.zig");
    const test_cell_step = b.step("test-cell", "Tests cell.zig file");
    test_cell_step.dependOn(&test_cell.step);
}
