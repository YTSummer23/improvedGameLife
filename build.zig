const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("sfml", "src/main.zig");
    exe.linkLibC();
    exe.addPackagePath("theGame", "sfml-wrapper/src/sfml/sfml.zig");
    exe.linkSystemLibrary("csfml-graphics");
    exe.linkSystemLibrary("csfml-system");
    exe.linkSystemLibrary("csfml-window");
    exe.linkSystemLibrary("csfml-audio");
    exe.addIncludeDir("csfml/include/"); // Not always necessary
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_step = b.step("run", "Run the game");
    run_step.dependOn(&exe.run().step);
}
