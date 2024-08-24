package main

import rl "vendor:raylib"

base_ball_width :: 10
ball_position: [2]f32 = {screen_width / 2, screen_height - 50}
ball_radius: f32 = base_ball_width
ball_direction: [2]f32 = {1, -1}
ball_speed: f32 = 300

Ball :: struct {
    center:    [2]f32,
    radius:    f32,
    direction: [2]f32,
    speed:     f32,
}

// TODO: create a pool of balls to use instead
ball := Ball {
    center    = ball_position,
    radius    = ball_radius,
    direction = ball_direction,
    speed     = ball_speed,
}

update_ball :: proc(delta: f32) {
    // Bounce off the walls
    if ball.center.x < ball.radius {
        ball.direction.x = abs(ball.direction.x)
    } else if ball.center.x > screen_width - ball.radius {
        ball.direction.x = -abs(ball.direction.x)
    }

    // Bounce off the ceiling
    if ball.center.y <= ball.radius {
        ball.direction.y = abs(ball.direction.y)
    } else if ball.center.y > screen_height - ball.radius {
        // Game over if we hit the bottom of the screen
        current_screen = GameScreen.Ending
    }

    rect := rl.Rectangle {
        x      = player_position_x - f32(half_player_width),
        y      = f32(screen_height) - f32(player_height) / 2,
        width  = f32(player_width),
        height = f32(player_height),
    }


    // Respond to collision with the paddle
    collided := handle_ball_aabb_collision(&ball, &rect)

    // Always make the ball go up after hitting the paddle
    if collided {
        ball.direction.y = -abs(ball.direction.y)
    }

    for &brick in bricks {
        if brick.position.x < 0 || brick.position.y < 0 {
            continue
        }

        rect = rl.Rectangle {
            brick.position.x,
            brick.position.y,
            brick_dimensions.x,
            brick_dimensions.y,
        }

        collided = handle_ball_aabb_collision(&ball, &rect)

        if collided {
            brick.position = {-1, -1}
        }
    }

    // Update the ball position
    ball.center += rl.Vector2Normalize(ball.direction) * ball.speed * delta
}

handle_ball_aabb_collision :: proc(ball: ^Ball, rect: ^rl.Rectangle) -> bool {
    collided, direction := test_circle_aabb_collision(ball, rect)

    if collided {
        switch direction {
        case .Up:
            ball.direction.y = -abs(ball.direction.y)
        case .Down:
            ball.direction.y = abs(ball.direction.y)
        case .Left:
            ball.direction.x = abs(ball.direction.x)
        case .Right:
            ball.direction.x = -abs(ball.direction.x)
        }
    }

    return collided
}

reset_ball :: proc() {
    ball.center = {screen_width / 2, screen_height - 50}
    ball.direction = {1, -1}
}
