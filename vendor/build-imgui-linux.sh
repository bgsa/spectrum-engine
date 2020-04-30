#!/bin/bash

set echo off

export BUILD_DIR=imgui/build
export BUILD_TYPE=Release
export SHARED_LIB=OFF
export OUTPUT_DIR_32=../../lib/x86/$BUILD_TYPE/
export OUTPUT_DIR_64=../../lib/x86_64/$BUILD_TYPE/

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
create_dir $OUTPUT_DIR_32
cd $BUILD_DIR


cmake .. -G "Unix Makefiles"                   \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB   \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON         \
	-DOPERATING_SYSTEM:STRING=LINUX        \
	-DOUTPUT_LIB_DIR:STRING=$OUTPUT_DIR_32 \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config $BUILD_TYPE

cd ../../

make_build_dir
create_dir $OUTPUT_DIR_64
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                   \
	-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB   \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON         \
	-DOPERATING_SYSTEM:STRING=LINUX        \
	-DOUTPUT_LIB_DIR:STRING=$OUTPUT_DIR_64 \
	-DCMAKE_C_FLAGS:STRING="-m64"             

cmake --build . --config $BUILD_TYPE

cd ../../

clear_build_dir
