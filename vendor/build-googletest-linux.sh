#!/bin/bash

set echo off

export BUILD_DIR=googletest/build
export BUILD_TYPE=Release
export OUTPUT_DIR_32=lib/x86
export OUTPUT_DIR_64=lib/x86_64

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

cmake .. -G "Unix Makefiles"                  \
	-DBUILD_SHARED_LIBS:BOOL=OFF          \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON        \
	-DCMAKE_CXX_FLAGS="-fPIC"             \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config Release

cd ../../

create_dir $OUTPUT_DIR_32/$BUILD_TYPE/
cp -f $BUILD_DIR/lib/libgtest.a        $OUTPUT_DIR_32/$BUILD_TYPE/
cp -f $BUILD_DIR/lib/libgtest_main.a   $OUTPUT_DIR_32/$BUILD_TYPE/

make_build_dir
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                  \
	-DBUILD_SHARED_LIBS:BOOL=OFF          \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON        \
	-DCMAKE_CXX_FLAGS="-fPIC"             \
	-DCMAKE_C_FLAGS:STRING="-m64"             

cmake --build . --config Release

cd ../../

create_dir $OUTPUT_DIR_64/$BUILD_TYPE/
cp -f $BUILD_DIR/lib/libgtest.a        $OUTPUT_DIR_64/$BUILD_TYPE/
cp -f $BUILD_DIR/lib/libgtest_main.a   $OUTPUT_DIR_64/$BUILD_TYPE/

clear_build_dir
