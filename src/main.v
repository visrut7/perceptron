module main

import os
import ppm
import input_layer { InputLayer }
import perceptron { Perceptron }

const width = 20

fn main() {
	if !os.is_dir('./images') {
		os.mkdir('images')!
	}

	mut matrix := [][]f64{len: width, init: []f64{len: width, init: 0}}
	mut layer := InputLayer{matrix, width}

	mut weights := [][]f64{len: width, init: []f64{len: width, init: 1}}
	mut nn := Perceptron{weights}

	for _ in 0 .. 20 {
		layer.draw_random_circle()
		a1 := nn.feed_forward(layer.get_matrix())
		if a1 > 0.5 {
			nn.sub_matrix(layer.get_matrix())
		}
		layer.clear_layer()

		layer.draw_random_rectangle()
		a2 := nn.feed_forward(layer.get_matrix())
		if a2 < 0.5 {
			nn.add_matrix(layer.get_matrix())
		}
		layer.clear_layer()
	}

	nn.apply_sigmoid()

	image1 := ppm.create_ppm_from_matrix(nn.get_weights())
	image1.save_image('images/perceptron.ppm')!
}
