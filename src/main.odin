package main

import "core:fmt"
import rl "vendor:raylib"

screen_width :: 800
screen_height :: 800

GameScreen :: enum {
    Logo = 0,
    Title,
    Gameplay,
    Ending,
}

main :: proc() {
    rl.InitWindow(screen_width, screen_height, "Breaker")
    defer rl.CloseWindow()

    rl.HideCursor()

    current_screen := GameScreen.Logo
    delta: f32

    for !rl.WindowShouldClose() {
        delta = rl.GetFrameTime()

        switch current_screen {
        case GameScreen.Logo:
            if rl.GetTime() > 3 || rl.IsKeyPressed(.ENTER) {
                current_screen = GameScreen.Title
            }
        case GameScreen.Title:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = GameScreen.Gameplay
            }
        case GameScreen.Gameplay:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = GameScreen.Ending
            }

            update_player(delta)
            update_ball(delta)
        case GameScreen.Ending:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = GameScreen.Title
            }
        }

        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)

        switch current_screen {
        case GameScreen.Logo:
            rl.DrawText("LOGO SCREEN", 20, 20, 40, rl.LIGHTGRAY)
            rl.DrawText("WAIT for 3 seconds...", 290, 220, 20, rl.GRAY)
        case GameScreen.Title:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.GREEN)
            rl.DrawText("Title Screen", 20, 20, 40, rl.DARKGREEN)
            rl.DrawText("Press Enter to start", 120, 220, 20, rl.DARKGREEN)
        case GameScreen.Gameplay:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.PURPLE)

            rl.DrawRectangle(
                i32(player_position_x) - half_player_width,
                screen_height - player_height,
                player_width,
                player_height,
                rl.BLUE,
            )

            rl.DrawCircleV(ball_position, ball_radius, rl.RED)

        case GameScreen.Ending:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.BLUE)
            rl.DrawText("Ending Screen", 20, 20, 40, rl.DARKBLUE)
            rl.DrawText("Press Enter to retry", 120, 220, 20, rl.DARKBLUE)
        }

        rl.EndDrawing()
    }
}
