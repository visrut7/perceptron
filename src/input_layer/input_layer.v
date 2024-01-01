module input_layer

import rand

pub struct InputLayer {
mut:
	matrix [][]f64 @[required]
	width  int     @[required]
}

pub fn (mut layer InputLayer) draw_random_circle() {
	// Adding a buffer to reduce the chances of the circle touching the grid edges
	buffer := 2

	// Calculate the radius within a range that considers the buffer
	radius := rand.int_in_range(2, layer.width / 2 - buffer - 1) or { return }

	// Adjust point displacement to account for the buffer
	point_displacement := rand.int_in_range(radius + buffer, layer.width - radius - buffer) or {
		return
	}

	for i in 0 .. layer.matrix.len {
		for j in 0 .. layer.matrix[0].len {
			// Calculate the distance from the center
			di := i - point_displacement
			dj := j - point_displacement

			// Check if the point is inside the circle and assign 1.0 to inputs[i][j]
			if di * di + dj * dj <= radius * radius {
				layer.matrix[i][j] = 1.0
			}
		}
	}
}

pub fn (mut layer InputLayer) draw_random_rectangle() {
	min_dimension := 3 // Minimum dimension for the rectangle

	// Randomly determine the top-left corner of the rectangle
	top_left_x := rand.int_in_range(0, layer.width - min_dimension) or { return }
	top_left_y := rand.int_in_range(0, layer.width - min_dimension) or { return }

	// Randomly determine the dimensions of the rectangle
	rect_width := rand.int_in_range(min_dimension, layer.width - top_left_x) or { return }
	rect_height := rand.int_in_range(min_dimension, layer.width - top_left_y) or { return }

	// Fill the rectangle area in inputs with 1.0
	for i in 0 .. layer.matrix.len {
		for j in 0 .. layer.matrix[0].len {
			if i >= top_left_x && i < top_left_x + rect_width && j >= top_left_y
				&& j < top_left_y + rect_height {
				layer.matrix[i][j] = 1.0
			}
		}
	}
}

pub fn (mut layer InputLayer) clear_layer() {
	for mut row in layer.matrix {
		for mut cell in row {
			cell = 0.0
		}
	}
}

pub fn (mut layer InputLayer) print_matrix() {
	for row in layer.matrix {
		println(row)
	}
}

pub fn (mut layer InputLayer) get_matrix() [][]f64 {
	return layer.matrix
}
