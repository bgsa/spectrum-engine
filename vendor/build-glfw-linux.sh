#!/bin/bash

set echo off

export BUILD_DIR=glfw/build
export BUILD_TYPE=Release
export SHARED_LIB=OFF
export OUTPUT_DIR_32=../../lib/x86
export OUTPUT_DIR_64=../../lib/x86_64

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                  \
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF            \
	-DGLFW_BUILD_TESTS:BOOL=OFF               \
	-DGLFW_BUILD_DOCS:BOOL=OFF                \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB      \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE     \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config $BUILD_TYPE

if [ "$SHARED_LIB" == "OFF" ]; then
	cp src/libglfw3.a   $OUTPUT_DIR_32
else
	cp src/libglfw3.so  $OUTPUT_DIR_32
fi

cd ../../

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi


mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                  \
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF            \
	-DGLFW_BUILD_TESTS:BOOL=OFF               \
	-DGLFW_BUILD_DOCS:BOOL=OFF                \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB      \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE     \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
	-DCMAKE_C_FLAGS:STRING="-m64"

cmake --build . --config $BUILD_TYPE

if [ "$SHARED_LIB" == "OFF" ]; then
	cp src/libglfw3.a   $OUTPUT_DIR_64
else
	cp src/libglfw3.so  $OUTPUT_DIR_64
fi

cd ../../

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi
