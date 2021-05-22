set echo off

export current_dir=$(pwd)

export OUTPUT_DIR=./include/stb

if [ -d $OUTPUT_DIR ]; then
	rm -rf $OUTPUT_DIR
fi

mkdir $OUTPUT_DIR

cp "./stb/stb_image.h"        "$OUTPUT_DIR"
cp "./stb/stb_image_resize.h" "$OUTPUT_DIR"
cp "./stb/stb_image_write.h"  "$OUTPUT_DIR"
