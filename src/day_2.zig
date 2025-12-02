const std = @import("std");

pub fn execute(gpa: std.mem.Allocator) !void {
    const file = try std.fs.cwd().openFile("src/day_2_input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, ",");

    // var final_string = [_]u8{};

    while (lines.next()) |line| {
        var ranges = std.mem.tokenizeAny(u8, line, "-");

        const lower_str = std.mem.trim(u8, ranges.next().?, "\n\r");
        const upper_str = std.mem.trim(u8, ranges.next().?, "\n\r");
        // const max_search_size = upper_str.len;
        const lower_int = try std.fmt.parseUnsigned(u64, lower_str, 10);
        const upper_int = try std.fmt.parseUnsigned(u64, upper_str, 10);
        var counter = lower_int;
        std.debug.print("{d}", .{lower_int});

        while (counter < upper_int) {
            // var current_size: usize = 0;
            counter += 1;
        }
    }
}

fn check_for_duplicates() !void {}
