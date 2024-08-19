package main

import rl "vendor:raylib"

base_ball_width :: 10
ball_position: [2]f32 = {screen_width / 2, screen_height / 2}
ball_radius: i32 = base_ball_width
ball_direction: [2]f32 = {}
max_ball_speed: f32 = 250
// max_ball_speed_squared := max_player_speed * max_player_speed

update_ball :: proc(delta: f32) {
    // TODO: update the ball
}
