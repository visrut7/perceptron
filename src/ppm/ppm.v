module ppm

import os

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

pub fn save_ppm_to_file(ppm PPM, file_name string) ! {
	mut file := os.open_file(file_name, 'w')!
	file.write_string('${ppm.magic_number}\n')!
	file.write_string('${ppm.dimensions.x} ${ppm.dimensions.y}\n')!
	file.write_string('${ppm.max_value}\n')!

	for num in ppm.buffer {
		file.write_string('${num} ')!
	}

	file.close()
}
