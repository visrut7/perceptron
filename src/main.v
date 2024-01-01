module main

import os
import ppm
import input_layer { InputLayer }

const width = 20

fn main() {
	if !os.is_dir('./images') {
		os.mkdir('images')!
	}

	mut matrix := [][]f64{len: width, init: []f64{len: width, init: 0}}
	mut layer := InputLayer{matrix, width}

	layer.draw_random_circle()
	image1 := ppm.create_ppm_from_inputs(layer.get_matrix())
	ppm.save_ppm_to_file(image1, 'images/circle.ppm')!
	layer.clear_layer()

	layer.draw_random_rectangle()
	image2 := ppm.create_ppm_from_inputs(layer.get_matrix())
	ppm.save_ppm_to_file(image2, 'images/rectangle.ppm')!
	layer.clear_layer()
}
