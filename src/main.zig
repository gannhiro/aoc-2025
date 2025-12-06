const std = @import("std");
const day_1 = @import("day_1.zig");
const day_2 = @import("day_2.zig");
const day_3 = @import("day_3.zig");
const day_4 = @import("day_4.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer _ = gpa.deinit();

    // try day_1.execute(gpa.allocator());
    // try day_2.execute(gpa.allocator());
    // try day_3.execute_part1(gpa.allocator());
    // try day_3.execute_part2(gpa.allocator());
    try day_4.execute(gpa.allocator());
}
