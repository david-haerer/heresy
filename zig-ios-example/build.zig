const std = @import("std");
const builtin = @import("builtin");
const Allocator = std.mem.Allocator;
const Builder = std.Build;

pub fn build(b: *Builder) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "app",
        .root_source_file = .{ .path = "main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.addIncludePath(.{ .cwd_relative = "." });
    exe.linkLibC();

    const install_bin = b.addInstallArtifact(exe, .{});
    install_bin.step.dependOn(&exe.step);

    const install_path = try std.fmt.allocPrint(b.allocator, "{s}/bin/app", .{b.install_path});
    defer b.allocator.free(install_path);

    const install_exe = b.addInstallFile(.{ .path = install_path }, "bin/MadeWithZig.app/app");
    const install_plist = b.addInstallFile(.{ .path = "Info.plist" }, "bin/MadeWithZig.app/Info.plist");

    install_plist.step.dependOn(&install_bin.step);
    install_exe.step.dependOn(&install_plist.step);

    b.default_step.dependOn(&install_exe.step);
}
