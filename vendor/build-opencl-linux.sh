#!/bin/bash

set echo off

export BUILD_DIR=OpenCL-ICD-Loader/build
export OUTPUT_DIR_32=../../lib/x86
export OUTPUT_DIR_64=../../lib/x86_64
export HEADER_DIR=$(pwd)/OpenCL-Headers
export BUILD_TYPE=Release

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

make_build_dir
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                                   \
	-DBUILD_SHARED_LIBS:BOOL=OFF                           \
	-DWIN32:BOOL=OFF                                       \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                         \
	-DOPENCL_ICD_LOADER_HEADERS_DIR="$HEADER_DIR"          \
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"  \
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"  \
	-DCMAKE_C_FLAGS:STRING="-m32"

cmake --build . --config $BUILD_TYPE

cd ../../

cp -f OpenCL-ICD-Loader/build/libOpenCL.a     lib/x86/$BUILD_TYPE/

make_build_dir
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                                   \
	-DBUILD_SHARED_LIBS:BOOL=OFF                           \
	-DWIN32:BOOL=OFF                                       \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                         \
	-DOPENCL_ICD_LOADER_HEADERS_DIR="$HEADER_DIR"          \
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"  \
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"  \
	-DCMAKE_C_FLAGS:STRING="-m64"

cmake --build . --config $BUILD_TYPE

cd ../../

cp -f OpenCL-ICD-Loader/build/libOpenCL.a     lib/x86_64/$BUILD_TYPE/

clear_build_dir
