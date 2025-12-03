const std = @import("std");

pub fn execute(gpa: std.mem.Allocator) !void {
    const file = try std.fs.cwd().openFile("src/day_2_input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, ",");

    var total_sum: u128 = 0;

    while (lines.next()) |line| {
        var ranges = std.mem.tokenizeAny(u8, line, "-");
        const lower_str = std.mem.trim(u8, ranges.next().?, "\n\r");
        const upper_str = std.mem.trim(u8, ranges.next().?, "\n\r");
        const lower_int = try std.fmt.parseUnsigned(u64, lower_str, 10);
        const upper_int = try std.fmt.parseUnsigned(u64, upper_str, 10);
        var counter = lower_int;

        while (counter <= upper_int) {
            var slice_to_compare_buf: [32]u8 = undefined;
            const slice_to_compare = try std.fmt.bufPrint(&slice_to_compare_buf, "{}", .{counter});

            if (slice_to_compare.len % 2 != 0) {
                counter += 1;
                continue;
            }

            const split: usize = @divExact(slice_to_compare.len, 2);
            const first_half = slice_to_compare[0..split];
            const second_half = slice_to_compare[split..];

            if (std.mem.eql(u8, first_half, second_half)) {
                total_sum += counter;
            }

            var divisor: usize = 1;
            while (divisor < slice_to_compare.len) {
                if (slice_to_compare.len % divisor != 0) {
                    divisor += 1;
                    continue;
                }

                var start: usize = 0;
                var end: usize = divisor;

                while (end < slice_to_compare.len) {
                    const slice = slice_to_compare[start..end];
                }

                divisor += 1;
            }

            counter += 1;
        }
    }

    std.debug.print("{d}", .{total_sum});
}

fn check_for_duplicates() !void {}
