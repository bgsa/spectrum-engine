#!/bin/bash

source ../build-base-linux.sh

export HEADER_DIR=$(pwd)/OpenCL-Headers

build()
{
	export BUILD_DIR=OpenCL-ICD-Loader/build
	export BUILD_TYPE=$2
	export OUTPUT_DIR=../../lib/$3/$BUILD_TYPE/

	make_build_dir
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"                                 \
		-DBUILD_SHARED_LIBS:BOOL=$4                          \
		-DWIN32:BOOL=OFF                                     \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON                       \
		-DOPENCL_ICD_LOADER_HEADERS_DIR=$HEADER_DIR          \
		-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING=$OUTPUT_DIR  \
		-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING=$OUTPUT_DIR  \
		-DCMAKE_C_FLAGS:STRING="-m$1"

	cmake --build . --config $BUILD_TYPE$1

	cd ../../
}

if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86    OFF
	build 32 Release x86    OFF
fi

build 64 Debug   x86_64 OFF
build 64 Release x86_64 OFF

export OUTPUT_DIR=include/CL/
if [ -d $OUTPUT_DIR ]; then
    rm -rf $OUTPUT_DIR
fi
mkdir -p "$OUTPUT_DIR"

cp -R "$HEADER_DIR/CL" "include"