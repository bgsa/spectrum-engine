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
	export BUILD_TYPE=$2
	export OUTPUT_DIR=../../../../lib/$3/$BUILD_TYPE
	export BUILD_DIR=$(pwd)/glew-cmake/build/cmake/build

	create_dir $BUILD_DIR
	cd $BUILD_DIR

	cmake ../../../ -G "Unix Makefiles"  \
		-DBUILD_SHARED_LIBS:BOOL=$4      \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON   \
		-DCMAKE_MACOSX_RPATH:BOOL=ON     \
		-DCMAKE_C_FLAGS:STRING="-m$1"    \
		-DCMAKE_CXX_FLAGS:STRING="-m$1"

	cmake --build . --config $BUILD_TYPE$1

	cp $BUILD_DIR/lib/libglew.a    $OUTPUT_DIR/libGLEW.a

	cd ../
	clear_build_dir
	cd ../../../
}

#Copying header files
cp -f glew-cmake/include/GL/*.h  include/GL/


build 64 Debug   x86_64 OFF
build 64 Release x86_64 OFF

# if not MacOS...
if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86    OFF
	build 32 Release x86    OFF
fi