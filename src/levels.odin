package main

setup_level_01 :: proc() {
    for &ball in balls {
        ball = Ball {
            radius = -1,
        }
    }

    balls[0] = Ball {
        center    = {50, screen_height - 50},
        radius    = 10,
        direction = {1, -1},
        speed     = 300,
    }

    balls[1] = Ball {
        center    = {30, screen_height - 30},
        radius    = 10,
        direction = {-3, -1},
        speed     = 350,
    }

    balls[0].center = {screen_width / 2, screen_height - 50}
    balls[0].direction = {1, -1}

    for row in 0 ..< 4 {
        for col in 0 ..< 8 {
            bricks[row * 8 + col].position = {
                f32(col) * brick_dimensions.x,
                f32(row) * brick_dimensions.y,
            }
        }
    }
}