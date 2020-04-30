#!/bin/bash

set echo off

export BUILD_DIR=glfw/build
export BUILD_TYPE=Release
export SHARED_LIB=OFF
export OUTPUT_DIR_32=../../lib/x86
export OUTPUT_DIR_64=../../lib/x86_64

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

cmake .. -G "Unix Makefiles"                      \
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF            \
	-DGLFW_BUILD_TESTS:BOOL=OFF               \
	-DGLFW_BUILD_DOCS:BOOL=OFF                \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB      \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE     \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config $BUILD_TYPE

create_dir $OUTPUT_DIR_32/$BUILD_TYPE/

if [ "$SHARED_LIB" == "OFF" ]; then
	cp src/libglfw3.a   $OUTPUT_DIR_32/$BUILD_TYPE/
else
	cp src/libglfw3.so  $OUTPUT_DIR_32/$BUILD_TYPE/
fi


cd ../../

make_build_dir
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

create_dir $OUTPUT_DIR_64/$BUILD_TYPE/

if [ "$SHARED_LIB" == "OFF" ]; then
	cp src/libglfw3.a   $OUTPUT_DIR_64/$BUILD_TYPE/
else
	cp src/libglfw3.so  $OUTPUT_DIR_64/$BUILD_TYPE/
fi

cd ../../

clear_build_dir
