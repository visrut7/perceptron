module ppm

import os

fn test_save_image() {
	image := PPM{
		dimensions: ImageDimensions{
			x: 2
			y: 2
		}
		buffer: [1, 1, 2, 3]
	}

	image.save_image('/tmp/test.ppm')!

	image_file := os.read_file('/tmp/test.ppm')!

	assert image_file.contains('P3\n2 2\n255\n1 1 2 3')
}
