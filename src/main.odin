package main

import rl "vendor:raylib"

INITIAL_SCREEN_HEIGHT :: 360
INITIAL_SCREEN_WIDTH :: 480

main :: proc() {
    rl.InitWindow(INITIAL_SCREEN_WIDTH, INITIAL_SCREEN_HEIGHT, "Breaker")

    for !rl.WindowShouldClose() {
        // TODO: update game here
        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawText("Hello, World!", 20, 20, 20, rl.LIGHTGRAY)

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
