package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

Ball :: struct {
    center:    [2]f32,
    radius:    f32,
    direction: [2]f32,
    speed:     f32,
}

balls: [10]Ball

update_ball :: proc(ball: ^Ball, delta: f32) {
    if ball.radius < 0 {
        return
    }

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
        ball.radius = -1
        ball.center = {-1, -1}
    }

    rect := rl.Rectangle {
        x      = player_position_x - f32(half_player_width),
        y      = f32(screen_height) - f32(player_height) / 2,
        width  = f32(player_width),
        height = f32(player_height),
    }


    // Respond to collision with the paddle
    collided := handle_ball_aabb_collision(ball, &rect)

    // Always make the ball go up after hitting the paddle
    if collided {
        ball.direction.y = -abs(ball.direction.y)

        if abs(player_speed) > 20 {
            // TODO: add some of the paddle's horizontal speed to the paddle
            ball.direction.x = math.copy_sign(ball.direction.x, player_speed)
        }
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

        collided = handle_ball_aabb_collision(ball, &rect)

        if collided {
            brick.position = {-1, -1}
            score += 1
            fmt.println("Score: ", score)
        }
    }

    // Update the ball position
    ball.center += rl.Vector2Normalize(ball.direction) * ball.speed * delta
}

handle_ball_aabb_collision :: proc(ball: ^Ball, rect: ^rl.Rectangle) -> bool {
    collided, direction, difference := test_circle_aabb_collision(ball, rect)

    if collided {
        switch direction {
        case .Up:
            ball.direction.y = -abs(ball.direction.y)
            ball.center.y -= ball.radius - abs(difference.y)
        case .Down:
            ball.direction.y = abs(ball.direction.y)
            ball.center.y += ball.radius - abs(difference.y)
        case .Left:
            ball.direction.x = abs(ball.direction.x)
            ball.center.x += ball.radius - abs(difference.x)
        case .Right:
            ball.direction.x = -abs(ball.direction.x)
            ball.center.x -= ball.radius - abs(difference.x)
        }
    }

    return collided
}

count_active_balls :: proc() -> int {
    count := 0
    for ball in balls {
        if ball.radius > 0 {
            count += 1
        }
    }
    return count
}
