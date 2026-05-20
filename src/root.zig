//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

pub fn runFile(_: std.mem.Allocator, filename: []const u8) !void {
    std.debug.print("Running {s}\n", .{filename});
    var threaded: std.Io.Threaded = .init_single_threaded;
    const io = threaded.io();
    const cwd = std.Io.Dir.cwd();
    const file = try std.Io.Dir.openFile(cwd, io, filename, .{});
    defer file.close(io);
    //var buffer: std.ArrayList(u8) = .empty;
    //defer buffer.deinit(allocator);
    var buffer: [10]u8 = undefined;
    var file_reader = std.Io.File.reader(file, io, &buffer);
    var reader = &file_reader.interface;
    try reader.fillMore();
    std.debug.print("{s}\n", .{reader.buffered()});
}
