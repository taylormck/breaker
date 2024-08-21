package main

import "core:fmt"

brick_dimensions: [2]f32 : {100, 40}

Brick :: struct {
    position: [2]f32,
}

bricks: [100]Brick

reset_bricks :: proc() {
    for &brick in bricks {
        brick.position = {-1, -1}
    }
}

setup_level_01 :: proc() {
    for i in 0 ..< 8 {
        bricks[i].position = {f32(i) * brick_dimensions.x, 0}
        fmt.printf("brick: %d, position: %v\n", i, bricks[i])
    }
}
