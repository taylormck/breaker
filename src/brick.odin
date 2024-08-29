package main

import "core:fmt"

brick_dimensions: [2]f32 : {100, 40}
half_brick_dimensions: [2]f32 = brick_dimensions / 2

Brick :: struct {
    position: [2]f32,
}

bricks: [100]Brick

reset_bricks :: proc() {
    for &brick in bricks {
        brick.position = {-1, -1}
    }
}

count_active_bricks :: proc() -> int {
    count := 0
    for &brick in bricks {
        if brick.position.x > 0 {
            count += 1
        }
    }
    return count
}
