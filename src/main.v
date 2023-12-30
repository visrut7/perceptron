module main

import rand
import ppm

const width = 20

fn draw_random_circle(mut inputs [width][width]f64) {
	// Adding a buffer to reduce the chances of the circle touching the grid edges
	buffer := 2

	// Calculate the radius within a range that considers the buffer
	radius := rand.int_in_range(2, width / 2 - buffer - 1) or { return }

	// Adjust point displacement to account for the buffer
	point_displacement := rand.int_in_range(radius + buffer, width - radius - buffer) or { return }

	for i in 0 .. inputs.len {
		for j in 0 .. inputs[0].len {
			// Calculate the distance from the center
			di := i - point_displacement
			dj := j - point_displacement

			// Check if the point is inside the circle and assign 1.0 to inputs[i][j]
			if di * di + dj * dj <= radius * radius {
				inputs[i][j] = 1.0
			}
		}
	}
}

fn draw_random_rectangle(mut inputs [width][width]f64) {
	min_dimension := 3 // Minimum dimension for the rectangle

	// Randomly determine the top-left corner of the rectangle
	top_left_x := rand.int_in_range(0, width - min_dimension) or { return }
	top_left_y := rand.int_in_range(0, width - min_dimension) or { return }

	// Randomly determine the dimensions of the rectangle
	rect_width := rand.int_in_range(min_dimension, width - top_left_x) or { return }
	rect_height := rand.int_in_range(min_dimension, width - top_left_y) or { return }

	// Fill the rectangle area in inputs with 1.0
	for i in 0 .. inputs.len {
		for j in 0 .. inputs[0].len {
			if i >= top_left_x && i < top_left_x + rect_width && j >= top_left_y
				&& j < top_left_y + rect_height {
				inputs[i][j] = 1.0
			}
		}
	}
}

fn print_matrix(matrix [width][width]f64) {
	for row in matrix {
		println(row)
	}
}

fn main() {
	mut inputs := [width][width]f64{}

	draw_random_circle(mut inputs)

	image1 := ppm.create_ppm_from_inputs(inputs)
	ppm.save_ppm_to_file(image1, 'images/circle.ppm')!

	draw_random_rectangle(mut inputs)

	image2 := ppm.create_ppm_from_inputs(inputs)
	ppm.save_ppm_to_file(image2, 'images/rectangle.ppm')!
}
