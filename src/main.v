module main

import os
import ppm

fn main() {
	image_dimensions := ppm.ImageDimensions{
		x: 1
		y: 1
	}

	image1 := ppm.PPM{
		max_value: 255
		dimensions: image_dimensions
		buffer: [0, 255, 0]
	}

	if !os.is_dir('images') {
		os.mkdir('images') or { panic(err) }
	}

	ppm.save_ppm_to_file(image1, 'images/image1.ppm')
}
