package main

import rl "vendor:raylib"

base_ball_width :: 10
ball_position: [2]f32 = {screen_width / 2, screen_height - 50}
ball_radius: f32 = base_ball_width
ball_direction: [2]f32 = {1, -1}
ball_speed: f32 = 300

update_ball :: proc(delta: f32) {
    // Bounce off the walls and ceiling
    if ball_position.x < ball_radius ||
       ball_position.x > screen_width - ball_radius {
        ball_direction.x *= -1
    }

    if ball_position.y < ball_radius {
        ball_direction.y *= -1
    }

    // TODO: detect contact with the bottom of the screen

    // TODO: detect contact with a paddle

    ball_position += rl.Vector2Normalize(ball_direction) * ball_speed * delta
}
