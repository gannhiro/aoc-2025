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

    while (lines.next()) |line| {
        var current_largest_num: u8 = 0 + 48;
        var position: u8 = 0;
        const size: usize = 12;

        while (position + size <= line.len) {
            if (line[position] == 57) {
                current_largest_num = 57;
                break;
            }

            if (current_largest_num < line[position]) {
                current_largest_num = line[position];
            }

            position += 1;
        }
    }
}

// find the biggest starting number where it has extra spaces +12
//
