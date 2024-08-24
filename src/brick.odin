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

// TODO: create a separate system for initializing levels
setup_level_01 :: proc() {
    for row in 0 ..< 4 {
        for col in 0 ..< 8 {
            bricks[row * 8 + col].position = {
                f32(col) * brick_dimensions.x,
                f32(row) * brick_dimensions.y,
            }
        }
    }
}
