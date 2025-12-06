const std = @import("std");

pub fn execute_part1(gpa: std.mem.Allocator) !void {
    const file = try std.fs.cwd().openFile("src/day_3_input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, "\n");

    var total: u64 = 0;

    while (lines.next()) |line| {
        var first_number_check: u8 = 9;
        var second_number_check: u8 = 9;
        var first_num_pos: usize = 0;
        var second_number_pos: usize = 0;

        var found = false;

        while (first_number_check > 0) {
            first_num_pos = 0;
            found = false;

            while (first_num_pos < line.len) {
                const number = try std.fmt.parseUnsigned(u8, line[first_num_pos .. first_num_pos + 1], 10);

                if (first_number_check == number) {
                    found = true;
                    break;
                }

                first_num_pos += 1;
            }

            if (found and first_num_pos < line.len - 1) break;

            if (first_number_check == 0) break;
            first_number_check -= 1;
        }

        if (first_num_pos != line.len - 1) {
            second_number_pos = first_num_pos + 1;
        }

        while (second_number_check > 0) {
            second_number_pos = first_num_pos + 1;
            found = false;

            while (second_number_pos < line.len) {
                const number = try std.fmt.parseUnsigned(u8, line[second_number_pos .. second_number_pos + 1], 10);

                if (second_number_check == number) {
                    found = true;
                    break;
                }

                second_number_pos += 1;
            }

            if (found) break;

            second_number_check -= 1;
        }

        const final_number_str = [_]u8{ first_number_check + 48, second_number_check + 48 };
        const final_number = try std.fmt.parseUnsigned(u8, &final_number_str, 10);

        total += final_number;
    }

    std.debug.print("{d}", .{total});
}

pub fn execute_part2(gpa: std.mem.Allocator) !void {
    const file = try std.fs.cwd().openFile("src/day_3_input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, "\n");

    var total_amount: u64 = 0;

    while (lines.next()) |line| {
        const size: usize = 12;
        var final_slice = [_]u8{0} ** size;
        var final_slice_pos: usize = 0;
        var scan_index: usize = 0;

        while (final_slice_pos < size) {
            const end_index = line.len - (size - final_slice_pos) + 1;
            var position: usize = scan_index;

            while (position < end_index) {
                if (final_slice[final_slice_pos] < line[position]) {
                    final_slice[final_slice_pos] = line[position];
                    scan_index = position + 1;
                }
                position += 1;
            }

            final_slice_pos += 1;
        }

        const num = try std.fmt.parseUnsigned(u64, &final_slice, 10);
        total_amount += num;
    }

    std.debug.print("{d}\n", .{total_amount});
}
