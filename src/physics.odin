package main

import rl "vendor:raylib"

Direction :: enum {
    Up,
    Down,
    Left,
    Right,
}

Direction_Vectors: [Direction][2]f32 = {
    .Up    = {0, 1},
    .Down  = {0, -1},
    .Left  = {-1, 0},
    .Right = {1, 0},
}

test_circle_aabb_collision :: proc(
    ball: ^Ball,
    rect: ^rl.Rectangle,
) -> (
    bool,
    Direction,
) {
    aabb_dimensions: [2]f32 = {rect.width, rect.height}
    aabb_half_dimensions := aabb_dimensions / 2
    aabb_center: [2]f32 = {rect.x, rect.y} + aabb_half_dimensions
    diff := ball.center - aabb_center

    clamped := rl.Vector2Clamp(
        diff,
        -half_brick_dimensions,
        half_brick_dimensions,
    )

    closest_point := aabb_center + clamped
    circle_center_to_closest_point := closest_point - ball.center
    distance_squared := rl.Vector2LengthSqr(circle_center_to_closest_point)

    is_collision := distance_squared <= ball.radius * ball.radius
    collision_direction := vector_direction(circle_center_to_closest_point)

    return is_collision, collision_direction
}

vector_direction :: proc(vector: [2]f32) -> Direction {
    current_max: f32 = 0
    best_match := Direction.Up

    for direction in Direction {
        direction_vector := Direction_Vectors[direction]
        dot_product := rl.Vector2DotProduct(
            rl.Vector2Normalize(vector),
            direction_vector,
        )

        if dot_product > current_max {
            current_max = dot_product
            best_match = direction
        }
    }

    return best_match
}
