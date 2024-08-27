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
