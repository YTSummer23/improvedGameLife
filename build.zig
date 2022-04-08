const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("theGame", "src/main.zig");
    exe.linkLibC();
    exe.addPackagePath("sfml", "zig-sfml-wrapper/src/sfml/sfml.zig");
    exe.linkSystemLibrary("csfml-graphics");
    exe.linkSystemLibrary("csfml-system");
    exe.linkSystemLibrary("csfml-window");
    exe.linkSystemLibrary("csfml-audio");
    exe.addIncludeDir("csfml/include/"); // Not always necessary
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.emit_docs = .emit;
    exe.install();

    const run_step = b.step("run", "Run the game");
    run_step.dependOn(&exe.run().step);

    const test_geometry = b.addTest("src/geometry.zig");
    test_geometry.addPackagePath("sfml", "zig-sfml-wrapper/src/sfml/sfml.zig");
    test_geometry.linkSystemLibrary("csfml-system");
    test_geometry.addIncludeDir("csfml/include/");
    const test_geometry_step = b.step("test-geometry", "Tests geometry.zig file");
    test_geometry_step.dependOn(&test_geometry.step);

    const test_cell = b.addTest("src/cell.zig");
    test_cell.addPackagePath("sfml", "zig-sfml-wrapper/src/sfml/sfml.zig");
    test_cell.linkSystemLibrary("csfml-system");
    test_cell.addIncludeDir("csfml/include/");
    const test_cell_step = b.step("test-cell", "Tests cell.zig file");
    test_cell_step.dependOn(&test_cell.step);
}
