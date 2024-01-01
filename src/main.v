module main

import os
import rand
import input_layer { InputLayer }
import perceptron { Perceptron }

const width = 20
const bias = 20

fn train(mut nn Perceptron, mut layer InputLayer) {
	rand.seed([u32(1), 2])
	for _ in 0 .. 10000 {
		layer.draw_random_rectangle()
		if nn.feed_forward(layer.get_matrix()) > bias {
			nn.sub_matrix(layer.get_matrix())
		}
		layer.clear_layer()

		layer.draw_random_circle()
		if nn.feed_forward(layer.get_matrix()) < bias {
			nn.add_matrix(layer.get_matrix())
		}
		layer.clear_layer()
	}
}

fn test(nn Perceptron, mut layer InputLayer) f64 {
	rand.seed([u32(101), 11])

	mut correct_ans := 0.0
	for _ in 0 .. 100 {
		layer.clear_layer()
		layer.draw_random_circle()
		if nn.feed_forward(layer.get_matrix()) > bias {
			correct_ans += 1
		}

		layer.clear_layer()
	}

	return correct_ans / 100
}

fn main() {
	if !os.is_dir('./images') {
		os.mkdir('images')!
	}

	mut matrix := [][]f64{len: width, init: []f64{len: width, init: 0}}
	mut layer := InputLayer{matrix, width}

	mut weights := [][]f64{len: width, init: []f64{len: width, init: 1}}
	mut nn := Perceptron{weights}

	train(mut nn, mut layer)
	accuracy := test(nn, mut layer)
	println(accuracy)
}
