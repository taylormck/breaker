package main

import rl "vendor:raylib"

test_circle_aabb_collision :: proc(
    ball: ^Ball,
    aabb_origin: [2]f32,
    aabb_dimensions: [2]f32,
) -> bool {
    aabb_half_dimensions := aabb_dimensions / 2
    aabb_center := aabb_origin + aabb_half_dimensions
    diff := ball.center - aabb_center

    clamped := rl.Vector2Clamp(
        diff,
        -half_brick_dimensions,
        half_brick_dimensions,
    )

    closest_point := aabb_center + clamped
    circle_center_to_closest_point := closest_point - ball.center
    distance_squared := rl.Vector2LengthSqr(circle_center_to_closest_point)

    return distance_squared <= ball.radius * ball.radius
}
