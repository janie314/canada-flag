const std = @import("std");

const Point = struct { x: f64, y: f64 };

const Segment = struct { p: Point, q: Point, a1: i64, a2: i64, r: i64, t: i64 };

fn intersection(p: Point, q: Point) Point {
    return .{ .x = p.x + q.x, .y = p.y + q.y };
}

fn L(r: i64, t: i64) f64 {
    return r * @tan(t / 2);
}

pub fn main() !void {
    // segments that define the canadian flag
    const data = [_]Segment{
        .{ .p = .{ .x = -18, .y = -406 }, .q = .{ .x = -203, .y = -244 }, .a1 = 87, .a2 = 10, .r = 19, .t = 103 },
        .{ .p = .{ .x = -203, .y = -244 }, .q = .{ .x = -372, .y = -13 }, .a1 = 10, .a2 = 321, .r = 13, .t = 71 },
        .{ .p = .{ .x = -372, .y = -13 }, .q = .{ .x = -360, .y = 137 }, .a1 = 321, .a2 = 288, .r = 13, .t = 83 },
        .{ .p = .{ .x = -360, .y = 137 }, .q = .{ .x = -216, .y = 171 }, .a1 = 288, .a2 = 247, .r = 13, .t = 79 },
        .{ .p = .{ .x = -216, .y = 171 }, .q = .{ .x = -150, .y = 302 }, .a1 = 247, .a2 = 281, .r = 13, .t = 148 },
        .{ .p = .{ .x = -150, .y = 302 }, .q = .{ .x = 0, .y = 400 }, .a1 = 281, .a2 = 243, .r = 13, .t = 93 },
    };
    const file = try std.fs.cwd().createFile("canada-flag.svg", .{});
    defer file.close();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) @panic("TEST FAIL");
    }
    const mem = gpa.allocator();
    _ = try file.write("<svg width=\"1920\" height=\"960\" xmlns=\"http://www.w3.org/2000/svg\"><rect width=\"480\" height=\"960\" x=\"0\" y=\"0\" fill=\"#ef3340\" /><rect width=\"960\" height=\"960\" x=\"480\" y=\"0\" fill=\"white\" /><rect width=\"480\" height=\"960\" x=\"1440\" y=\"0\" fill=\"#ef3340\" />");
    for (data) |s| {
        const str = try std.fmt.allocPrint(mem, "<circle r=\"13\" cx=\"{d}\" cy=\"{d}\" fill=\"blue\"/>", .{ 960 + s.p.x, 480 - s.p.y });
        _ = try file.write(str);
        mem.free(str);
    }
    _ = try file.write("</svg>");
}
