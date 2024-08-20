package main

import "core:fmt"
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

    if is_contacting_paddle() {
        ball_direction.y = -abs(ball_direction.y)
    } else if ball_position.y > screen_height - ball_radius {
        fmt.printf("game over")
        current_screen = GameScreen.Ending
    }


    ball_position += rl.Vector2Normalize(ball_direction) * ball_speed * delta
}

is_contacting_paddle :: proc() -> bool {
    // TODO: use a more physically accurate algorithm to detect collision
    // with the paddle.
    return(
        i32(ball_position.y + ball_radius) > screen_height - player_height &&
        i32(ball_position.x + ball_radius) >=
            i32(player_position_x) - half_player_width &&
        i32(ball_position.x - ball_radius) <=
            i32(player_position_x) + half_player_width \
    )
}

reset_ball :: proc() {
    ball_position = {screen_width / 2, screen_height - 50}
    ball_direction = {1, -1}
}
