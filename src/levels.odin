package main

Level :: struct {
    balls:      [dynamic]Ball,
    num_balls:  int,
    brick_rows: int,
}

setup_level :: proc(level_number: uint) {
    level := levels[level_number]

    for &ball in balls {
        ball = Ball {
            radius = -1,
        }
    }

    for i in 0 ..< level.num_balls {
        balls[i] = level.balls[i]
    }

    reset_bricks()

    for row in 0 ..< level.brick_rows {
        for col in 0 ..< 8 {
            bricks[row * 8 + col].position = {
                f32(col) * brick_dimensions.x,
                f32(row) * brick_dimensions.y,
            }
        }
    }
}

levels: [3]Level = {
    {
        balls = {
            Ball {
                center = {50, screen_height - 50},
                radius = 10,
                direction = {1, -1},
                speed = 300,
            },
            Ball {
                center = {30, screen_height - 30},
                radius = 10,
                direction = {-3, -1},
                speed = 350,
            },
            Ball {
                center = {screen_width - 30, screen_height - 30},
                radius = 10,
                direction = {1, -2},
                speed = 200,
            },
        },
        num_balls = 3,
        brick_rows = 4,
    },
    {
        balls = {
            Ball {
                center = {50, screen_height - 50},
                radius = 10,
                direction = {1, -1},
                speed = 300,
            },
            Ball {
                center = {30, screen_height - 30},
                radius = 10,
                direction = {-3, -1},
                speed = 350,
            },
        },
        num_balls = 2,
        brick_rows = 5,
    },
    {
        balls = {
            Ball {
                center = {20, screen_height - 50},
                radius = 10,
                direction = {1, -1},
                speed = 300,
            },
            Ball {
                center = {30, screen_height - 30},
                radius = 10,
                direction = {-3, -1},
                speed = 350,
            },
            Ball {
                center = {screen_width - 30, screen_height - 30},
                radius = 10,
                direction = {1, -2},
                speed = 200,
            },
        },
        num_balls = 2,
        brick_rows = 6,
    },
}
