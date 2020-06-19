#!/bin/bash

set echo off

OS=$(uname -s)

create_dir()
{
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}
clear_build_dir()
{
	if [ -d $BUILD_DIR ]; then
		rm -rf $BUILD_DIR
	fi	  
}
make_build_dir()
{
	clear_build_dir
	create_dir $BUILD_DIR
}

build()
{
	export BUILD_DIR=glfw/build
	export BUILD_TYPE=$2
	export SHARED_LIB=OFF
	export OUTPUT_DIR=../../lib/$3

	make_build_dir
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"                      \
		-DGLFW_BUILD_EXAMPLES:BOOL=OFF            \
		-DGLFW_BUILD_TESTS:BOOL=OFF               \
		-DGLFW_BUILD_DOCS:BOOL=OFF                \
		-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB      \
		-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE     \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
		-DCMAKE_C_FLAGS:STRING="-m$1"

	cmake --build . --config $BUILD_TYPE$1

	create_dir $OUTPUT_DIR/$BUILD_TYPE/

	if [ "$SHARED_LIB" == "OFF" ]; then
		cp src/libglfw3.a   $OUTPUT_DIR/$BUILD_TYPE/
	else
		cp src/libglfw3.so  $OUTPUT_DIR/$BUILD_TYPE/
	fi

	cd ../../

	clear_build_dir
}

if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86    OFF
	build 32 Release x86    OFF
fi

build 64 Debug   x86_64 OFF
build 64 Release x86_64 OFF

