package main

import "core:fmt"
import rl "vendor:raylib"

screen_width :: 800
screen_height :: 800

GameScreen :: enum {
    Logo = 0,
    Title,
    Gameplay,
    NextLevel,
    Ending,
}

current_screen := GameScreen.Logo
current_level: uint = 1
score := 0

main :: proc() {
    rl.InitWindow(screen_width, screen_height, "Breaker")
    defer rl.CloseWindow()

    rl.HideCursor()

    delta: f32

    for !rl.WindowShouldClose() {
        delta = rl.GetFrameTime()

        switch current_screen {
        case .Logo:
            if rl.GetTime() > 3 || rl.IsKeyPressed(.ENTER) {
                current_screen = .Title
            }
        case .Title:
            if rl.IsKeyPressed(.ENTER) {
                player_reset()
                score = 0
                current_screen = .Gameplay
                current_level = 0
                setup_level(current_level)
            }
        case .Gameplay:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = .Ending
            }

            player_update(delta)

            for &ball in balls {
                ball_update(&ball, delta)
            }

            if ball_count_active() <= 0 {
                current_screen = .Ending
                fmt.println("GAME OVER")
            }

            if count_active_bricks() <= 0 {
                current_level += 1
                if current_level >= len(levels) {
                    current_screen = .Ending
                    fmt.println("YOU WIN")
                } else {
                    current_screen = .NextLevel
                    fmt.printfln("Level {} complete!", current_level)
                }
            }
        case .NextLevel:
            if rl.IsKeyPressed(.ENTER) {
                setup_level(current_level)
                current_screen = GameScreen.Gameplay
            }
        case .Ending:
            if rl.IsKeyPressed(.ENTER) {
                current_screen = .Title
            }
        }

        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)

        switch current_screen {
        case .Logo:
            rl.DrawText("LOGO SCREEN", 20, 20, 40, rl.LIGHTGRAY)
            rl.DrawText("WAIT for 3 seconds...", 290, 220, 20, rl.GRAY)
        case .Title:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.GREEN)
            rl.DrawText("Title Screen", 20, 20, 40, rl.DARKGREEN)
            rl.DrawText("Press Enter to start", 120, 220, 20, rl.DARKGREEN)
        case .Gameplay:
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

            for ball in balls {
                if ball.radius > 0 {
                    rl.DrawCircleV(ball.center, ball.radius, rl.RED)
                    rl.DrawCircleLinesV(ball.center, ball.radius, rl.BLACK)
                }
            }

        case .NextLevel:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.ORANGE)
            rl.DrawText(
                fmt.caprintf("Next level: {}", current_level + 1),
                20,
                20,
                40,
                rl.DARKGREEN,
            )
            rl.DrawText("Press Enter to start", 120, 220, 20, rl.DARKGREEN)

        case .Ending:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.BLUE)
            rl.DrawText("Ending Screen", 20, 20, 40, rl.DARKBLUE)
            rl.DrawText("Press Enter to retry", 120, 220, 20, rl.DARKBLUE)
        }

        rl.EndDrawing()
    }
}
