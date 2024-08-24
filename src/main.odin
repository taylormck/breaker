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

current_screen := GameScreen.Logo

main :: proc() {
    rl.InitWindow(screen_width, screen_height, "Breaker")
    defer rl.CloseWindow()

    rl.HideCursor()

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
                reset_ball()
                reset_player()
                current_screen = GameScreen.Gameplay
                reset_bricks()
                setup_level_01()
            }
        case GameScreen.Gameplay:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = GameScreen.Ending
            }

            update_player(delta)
            update_ball(delta)

            for &brick in bricks {
                if is_contacting_brick(&brick) {
                    brick.position = {-1, -1}
                }
            }
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

            for brick in bricks {
                if brick.position.x >= 0 && brick.position.y >= 0 {
                    rl.DrawRectangleV(
                        brick.position,
                        brick_dimensions,
                        rl.DARKGRAY,
                    )
                    rl.DrawRectangleLines(
                        i32(brick.position.x),
                        i32(brick.position.y),
                        i32(brick_dimensions.x),
                        i32(brick_dimensions.y),
                        rl.BLACK,
                    )
                }
            }

            rl.DrawRectangle(
                i32(player_position_x) - half_player_width,
                screen_height - player_height,
                player_width,
                player_height,
                rl.BLUE,
            )
            rl.DrawRectangleLines(
                i32(player_position_x) - half_player_width,
                screen_height - player_height,
                player_width,
                player_height,
                rl.BLACK,
            )

            rl.DrawCircleV(ball_position, ball_radius, rl.RED)
            rl.DrawCircleLinesV(ball_position, ball_radius, rl.BLACK)

        case GameScreen.Ending:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.BLUE)
            rl.DrawText("Ending Screen", 20, 20, 40, rl.DARKBLUE)
            rl.DrawText("Press Enter to retry", 120, 220, 20, rl.DARKBLUE)
        }

        rl.EndDrawing()
    }
}
