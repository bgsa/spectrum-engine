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
	export BUILD_DIR=OpenCL-ICD-Loader/build
	export BUILD_TYPE=$2
	export OUTPUT_DIR=../../lib/$3/$BUILD_TYPE/
	export HEADER_DIR=$(pwd)/OpenCL-Headers

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

