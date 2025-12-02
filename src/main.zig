const std = @import("std");
const day_1 = @import("day_1.zig");
const day_2 = @import("day_2.zig");

pub fn main() !void {
    const gpa = std.heap.page_allocator;
    try day_1.execute(gpa);
    try day_2.execute(gpa);
}
