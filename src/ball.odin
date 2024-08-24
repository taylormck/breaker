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
    // Bounce off the walls and ceiling
    if ball.center.x < ball.radius {
        ball.direction.x = abs(ball.direction.x)
    }
    if ball.center.x > screen_width - ball.radius {
        ball.direction.x = -abs(ball.direction.x)
    }

    if ball.center.y <= ball.radius {
        ball.direction.y = abs(ball.direction.y)
    }

    player_center: [2]f32 = {
        player_position_x - f32(half_player_width),
        f32(screen_height) - f32(player_height) / 2,
    }
    player_dimensions: [2]f32 = {f32(player_width), f32(player_height)}

    if test_circle_aabb_collision(&ball, player_center, player_dimensions) {
        ball.direction.y = -abs(ball.direction.y)
    } else if ball.center.y > screen_height - ball.radius {
        current_screen = GameScreen.Ending
    }

    ball.center += rl.Vector2Normalize(ball.direction) * ball.speed * delta
}

reset_ball :: proc() {
    ball.center = {screen_width / 2, screen_height - 50}
    ball.direction = {1, -1}
}
