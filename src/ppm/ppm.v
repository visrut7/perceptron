module ppm

import os
import math
import matrix { Matrix }

pub struct ImageDimensions {
	x int
	y int
}

pub struct PPM {
	magic_number string = 'P3'
	dimensions   ImageDimensions @[required]
	max_value    int = 255
	buffer       []int           @[required]
}

pub fn create_ppm_from_matrix(mat Matrix) PPM {
	dimensions := ImageDimensions{
		x: mat.len
		y: mat[0].len
	}

	mut buffer := []int{cap: dimensions.x * dimensions.y * 3}
	for row in mat {
		for value in row {
			// Convert the f64 value to an integer for grayscale (0 or 255)
			color_value := int(math.ceil(value * 255))
			// Append RGB components (all the same for grayscale)
			buffer << color_value
			buffer << color_value
			buffer << color_value
		}
	}

	return PPM{
		dimensions: dimensions
		buffer: buffer
	}
}

pub fn (image PPM) save_image(file_name string) ! {
	mut file := os.open_file(file_name, 'w')!
	file.write_string('${image.magic_number}\n')!
	file.write_string('${image.dimensions.x} ${image.dimensions.y}\n')!
	file.write_string('${image.max_value}\n')!

	for num in image.buffer {
		file.write_string('${num} ')!
	}

	file.close()
}
