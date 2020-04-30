#!/bin/bash

set echo off

export BUILD_DIR=gtest-runner/build
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

cmake .. -G "Unix Makefiles"                   \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config $BUILD_TYPE

cd ../../

create_dir bin/x86/$BUILD_TYPE/GoogleTestRunner/
cp -f $BUILD_DIR/gtest-runner   bin/x86/$BUILD_TYPE/GoogleTestRunner/

make_build_dir
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                   \
	-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
	-DCMAKE_C_FLAGS:STRING="-m64"

cmake --build . --config $BUILD_TYPE

cd ../../

create_dir bin/x86_64/$BUILD_TYPE/GoogleTestRunner/
cp -f $BUILD_DIR/gtest-runner   bin/x86_64/$BUILD_TYPE/GoogleTestRunner/

clear_build_dir
