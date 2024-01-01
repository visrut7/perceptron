module perceptron

import math
import matrix { Matrix }

pub struct Perceptron {
mut:
	weights Matrix
}

pub fn (p Perceptron) feed_forward(inputs Matrix) f64 {
	mut output := 0.0

	for i in 0 .. inputs.len {
		for j in 0 .. inputs[0].len {
			output += inputs[i][j] * p.weights[i][j]
		}
	}

	return sigmoid(output)
}

pub fn (mut p Perceptron) sub_matrix(mat Matrix) {
	for i in 0 .. mat.len {
		for j in 0 .. mat[0].len {
			p.weights[i][j] -= mat[i][j]
		}
	}
}

pub fn (mut p Perceptron) add_matrix(mat Matrix) {
	for i in 0 .. mat.len {
		for j in 0 .. mat[0].len {
			p.weights[i][j] += mat[i][j]
		}
	}
}

pub fn (p Perceptron) print_perceptron() {
	for row in p.weights {
		println(row)
	}
}

pub fn (mut p Perceptron) apply_sigmoid() {
	for i in 0 .. p.weights.len {
		for j in 0 .. p.weights[0].len {
			p.weights[i][j] = sigmoid(p.weights[i][j])
		}
	}
}

pub fn (p Perceptron) get_weights() Matrix {
	return p.weights
}

fn sigmoid(x f64) f64 {
	return 1.0 / (1.0 + math.exp(-x))
}
