#!/bin/bash

source ../build-base-linux.sh

build()
{
	export BUILD_DIR=imgui/build
	export BUILD_TYPE=$2
	export SHARED_LIB=$4
	export OUTPUT_DIR=../../lib/$3/$BUILD_TYPE/
	export LIB_DIR=../../lib/$3/$BUILD_TYPE/

	make_build_dir
	create_dir $OUTPUT_DIR
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"               \
		-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB   \
		-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON         \
		-DOPERATING_SYSTEM:STRING=LINUX        \
		-DOUTPUT_LIB_DIR:STRING=$OUTPUT_DIR    \
		-DCMAKE_C_FLAGS:STRING="-m$1"          \
		-DCMAKE_CXX_FLAGS:STRING="-m$1"        \
		-DCMAKE_GLEW_LIBRARIES:STRING=$LIB_DIR \
		-DCMAKE_LIBRARY_PATH:STRING=$LIB_DIR \

	cmake --build . --config $BUILD_TYPE$1

	cd ../../

	clear_build_dir

	# copy headers
	cd include
	if [ -d imgui ]; then
		rm -rf imgui
	fi
	mkdir imgui
	cp ../imgui/*.h  imgui
	cd ../
}

build 64 Debug   x86_64 OFF
build 64 Release x86_64 OFF