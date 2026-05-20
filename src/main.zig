const std = @import("std");
const zlox = @import("zlox");

pub fn main(init: std.process.Init) !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();
    const minimal = init.minimal;
    const args = try minimal.args.toSlice(alloc);
    if (args.len > 2) {
        std.debug.print("Usage: jlox [script]\n", .{});
    }
    else if (args.len == 2) {
        try zlox.runFile(alloc, args[1]);
    }
    else {
        std.debug.print("run prompt", .{});
    }
}

test "simple test" {
    std.debug.print("test\n");
}
