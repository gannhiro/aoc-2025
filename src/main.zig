const std = @import("std");

const min: u8 = 0;
const max: i32 = 100;
const left = "L"[0];

pub fn main() !void {
    try first_day();
}

fn first_day() !void {
    const gpa = std.heap.page_allocator;
    const file = try std.fs.cwd().openFile("src/input.txt", .{});
    defer file.close();

    const input_text = try file.readToEndAlloc(gpa, 1024 * 1024);

    var lines = std.mem.tokenizeAny(u8, input_text, "\n");

    var dial: i32 = 50;
    var dial_point_zero_count: i32 = 0;

    while (lines.next()) |line| {
        const turn = line[0];
        const turn_amount_init = std.mem.trim(u8, line[1..], "\n\r");
        const turn_amount = try std.fmt.parseInt(i32, turn_amount_init, 10);

        const zero_passes: i32 = @divFloor(turn_amount, max);
        dial_point_zero_count += zero_passes;

        if (turn == left) {
            if (dial != 0 and dial - @mod(turn_amount, max) <= 0) {
                dial_point_zero_count += 1;
            }
            dial = @mod(dial - turn_amount, max);
        } else {
            if (dial + @mod(turn_amount, max) >= 100) {
                dial_point_zero_count += 1;
            }
            dial = @mod(turn_amount + dial, max);
        }
    }

    std.debug.print("final count: {d}\n", .{dial_point_zero_count});
}
