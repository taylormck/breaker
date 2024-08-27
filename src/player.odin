package main

import rl "vendor:raylib"

base_paddle_width :: 100
player_position_x: f32 = screen_width / 2
player_width: i32 = base_paddle_width
half_player_width: i32 = player_width / 2
player_height: i32 = 20
player_speed: f32 = 0
max_player_speed: f32 = 350
player_acceleration: f32 = 10
paddle_transfer_rate :: 0.5

update_player :: proc(delta: f32) {
    target_velocity: f32 = 0

    if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) {
        target_velocity -= max_player_speed
    }

    if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) {
        target_velocity += max_player_speed
    }

    player_speed = rl.Lerp(
        player_speed,
        target_velocity,
        player_acceleration * delta,
    )

    player_position_x = clamp(
        player_position_x + player_speed * delta,
        f32(half_player_width),
        f32(screen_width - half_player_width),
    )
}

reset_player :: proc() {
    player_position_x = screen_width / 2
}
