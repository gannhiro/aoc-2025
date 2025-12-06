const std = @import("std");
const d_print = std.debug.print;

const Coords = struct { row: u8, column: u8 };

pub fn execute(gpa: std.mem.Allocator) !void {
    const file = try std.fs.cwd().openFile("src/inputs/day_4_input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, "\n");

    var paper_shelves: [140][140]u8 = undefined;
    var counter: usize = 0;

    while (lines.next()) |line| {
        var buf: [140]u8 = undefined;
        const final_init = std.mem.trim(u8, line, "\n\r");
        @memcpy(&buf, final_init[0..final_init.len]);
        paper_shelves[counter] = buf;
        counter += 1;
    }

    var total: u64 = 0;

    var surrounding_rolls: u8 = 0;

    var rolls_to_be_removed = std.ArrayList(Coords){};
    defer rolls_to_be_removed.deinit(gpa);

    while (true) {
        var row_counter: u8 = 0;

        rolls_to_be_removed.clearRetainingCapacity();

        while (row_counter < 140) {
            var column_counter: u8 = 0;

            while (column_counter < 140) {
                if (paper_shelves[row_counter][column_counter] == '@') {
                    const r_scout_start = if (row_counter > 0) row_counter - 1 else 0;
                    const r_scout_end = if (row_counter < 139) row_counter + 1 else 139;
                    const c_scout_start = if (column_counter > 0) column_counter - 1 else 0;
                    const c_scout_end = if (column_counter < 139) column_counter + 1 else 139;

                    var r_counter = r_scout_start;
                    var c_counter = c_scout_start;
                    while (r_counter <= r_scout_end) {
                        c_counter = c_scout_start;

                        while (c_counter <= c_scout_end) : (c_counter += 1) {
                            if (r_counter == row_counter and c_counter == column_counter) {
                                continue;
                            }

                            if (paper_shelves[r_counter][c_counter] == '@') {
                                surrounding_rolls += 1;
                            }
                        }

                        r_counter += 1;
                    }

                    if (surrounding_rolls < 4) {
                        try rolls_to_be_removed.append(gpa, .{ .row = row_counter, .column = column_counter });
                    }

                    surrounding_rolls = 0;
                }

                column_counter += 1;
            }

            row_counter += 1;
        }

        const temp_items = rolls_to_be_removed.items;

        if (temp_items.len == 0) {
            break;
        } else {
            total += temp_items.len;

            for (temp_items) |coord| {
                paper_shelves[coord.row][coord.column] = 'x';
            }
        }
    }

    std.debug.print("{d}", .{total});
}
