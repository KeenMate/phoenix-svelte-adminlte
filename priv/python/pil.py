from PIL import Image, ExifTags
from time import time
from os import listdir
from os.path import isfile, join, basename, splitext

def time_ms():
	return int(round(time() * 1000))

# def create_thumbnail(infile, size, outfile):
# 	isize = int(size)
# 	before_open = time_ms()
# 	with Image.open(infile) as img:
# 		after_open = time_ms()
# 		img.resize((isize, isize)).save(outfile, "webp")
# 		after_save = time_ms()
# 		return {
# 			"out_file": outfile,
# 			"all": after_save - before_open,
# 			"open_time": after_open - before_open,
# 			"save_time": after_save - after_open
# 		}


def create_thumbnail(infile, size, outfile):
	before_open = time_ms()
	with Image.open(infile) as img:
		after_open = time_ms()

		img = fix_image_orientation(img)

		original_width, original_height = img.size

		before_save = 0
		after_save = 0
		if original_height > original_width:
			resize_ratio = size / original_width
			new_size = original_height * resize_ratio
			img.thumbnail((new_size, new_size))

			before_save = time_ms()
			img.crop((0, (new_size - size) // 2, size, (new_size + size) // 2)).save(outfile, "webp")
			after_save = time_ms()
		else:
			resize_ratio = size / original_height
			new_size = original_width * resize_ratio
			img.thumbnail((new_size, new_size))

			before_save = time_ms()
			img.crop(((new_size - size) // 2, 0, (new_size + size) // 2, size)).save(outfile, "webp")
			after_save = time_ms()

		return {
			"out_file": outfile,
			"all": after_save - before_open,
			"open_time": after_open - before_open,
			"save_time": after_save - before_save
		}

def create_image(infile, outfile, max_dims):
	before_open = time_ms()
	with Image.open(infile) as img:
		after_open = time_ms()

		img = fix_image_orientation(img)

		width, height = img.size
		max_width, max_height = max_dims.split(b"x") if max_dims else [width, height]
		max_width, max_height = int(max_width), int(max_height)
		if max(width, max_width) > max_width:
			ratio = width / max_width
			new_height = int(height / ratio)
			img = img.resize((max_width, new_height))
		elif max(height, max_height) > max_height:
			ratio = height / max_height
			new_width = int(width / ratio)
			img = img.resize((new_width, max_height))

		before_save = time_ms()
		img.save(outfile, "webp")
		after_save = time_ms()

		return {
			"out_file": outfile,
			"all": after_save - before_open,
			"open_time": after_open - before_open,
			"save_time": after_save - before_save
		}

def fix_image_orientation(img):
	try:
		for orientation in ExifTags.TAGS.keys():
			if ExifTags.TAGS[orientation] == 'Orientation':
				break
		exif = dict(img._getexif().items())
		if exif[orientation] == 3:
			img = img.rotate(180, expand=True)
		elif exif[orientation] == 6:
			img = img.rotate(270, expand=True)
		elif exif[orientation] == 8:
			img = img.rotate(90, expand=True)
		return img
	except:
		return img

def process_dir(dir):
	content = [file_path for file_path in (join(dir, x) for x in listdir(dir)) if isfile(file_path)]
	before = time_ms()
	result = [res for res in (process_image(dir, x) for x in content)]
	after = time_ms()
	return {
		"result": result,
		"elapsed": after - before
	}

def process_image(dir, file):
	filename, ext = splitext(basename(file))
	out_image = join(dir, "out", filename)
	img_res = create_image(file, out_image + ".webp")
	thumb_res_75 = create_thumbnail(file, 75, out_image + "_75.webp")
	thumb_res_150 = create_thumbnail(file, 150, out_image + "_150.webp")
	thumb_res_300 = create_thumbnail(file, 300, out_image + "_300.webp")
	return [img_res, thumb_res_75, thumb_res_150, thumb_res_300]
