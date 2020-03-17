#!/bin/bash

set echo off

export BUILD_DIR=OpenCL-ICD-Loader/build
export OUTPUT_DIR_32=../../lib/x86
export OUTPUT_DIR_64=../../lib/x86_64
export HEADER_DIR=$(pwd)/OpenCL-Headers

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR


echo $HEADER_DIR

cmake .. -G "Unix Makefiles"                                                                         \
	-DBUILD_SHARED_LIBS:BOOL=OFF                                                        \
	-DWIN32:BOOL=OFF                                                                                \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                                \
	-DOPENCL_ICD_LOADER_HEADERS_DIR="$HEADER_DIR"                     \
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"     \
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"    \
	-DCMAKE_C_FLAGS:STRING="-m32"

cmake --build . --config Release

cd ../../

cp OpenCL-ICD-Loader/build/libOpenCL.a     lib/x86

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                                                                         \
	-DBUILD_SHARED_LIBS:BOOL=OFF                                                        \
	-DWIN32:BOOL=OFF                                                                                \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                                \
	-DOPENCL_ICD_LOADER_HEADERS_DIR="$HEADER_DIR"                     \
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"     \
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="$OUTPUT_DIR"    \
	-DCMAKE_C_FLAGS:STRING="-m64"

cmake --build . --config Release

cd ../../

cp OpenCL-ICD-Loader/build/libOpenCL.a     lib/x86_64

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi