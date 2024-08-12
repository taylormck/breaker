package main

import rl "vendor:raylib"

screen_width :: 800
screen_height :: 450

GameScreen :: enum {
    Logo = 0,
    Title,
    Gameplay,
    Ending,
}

main :: proc() {
    rl.InitWindow(screen_width, screen_height, "Breaker")

    current_screen := GameScreen.Logo

    for !rl.WindowShouldClose() {
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
            rl.DrawText("Gameplay Screen", 20, 20, 40, rl.MAROON)
            rl.DrawText("Press Enter to end", 130, 220, 20, rl.MAROON)
        case GameScreen.Ending:
            rl.DrawRectangle(0, 0, screen_width, screen_height, rl.BLUE)
            rl.DrawText("Ending Screen", 20, 20, 40, rl.DARKBLUE)
            rl.DrawText("Press Enter to retry", 120, 220, 20, rl.DARKBLUE)
        }

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
