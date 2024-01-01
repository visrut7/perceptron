module perceptron

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

	return output
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

pub fn (p Perceptron) get_weights() Matrix {
	return p.weights
}
