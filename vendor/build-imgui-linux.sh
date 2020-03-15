#!/bin/bash

set echo off

export BUILD_DIR=imgui/build
export BUILD_TYPE=Release
export SHARED_LIB=OFF
export OUTPUT_DIR_32=../../lib/x86
export OUTPUT_DIR_64=../../lib/x86_64

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                                      \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB     \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
	-DOPERATING_SYSTEM:STRING=LINUX             \
	-DOUTPUT_LIB_DIR:STRING=$OUTPUT_DIR_32   \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config $BUILD_TYPE

cd ../../

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                                      \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB     \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
	-DOPERATING_SYSTEM:STRING=LINUX             \
	-DOUTPUT_LIB_DIR:STRING=$OUTPUT_DIR_64   \
	-DCMAKE_C_FLAGS:STRING="-m64"             

cmake --build . --config $BUILD_TYPE

cd ../../

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi