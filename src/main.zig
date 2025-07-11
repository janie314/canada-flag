const std = @import("std");

const Point = struct { x: f64, y: f64 };

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    std.debug.print("here's a trig answer: {d:.3}\n", .{std.math.tan(std.math.pi * 0.45)});
}
