#!/bin/bash

set echo off

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
	export BUILD_DIR=gtest-runner/build
	export BUILD_TYPE=$2
	export BITS=$1

	make_build_dir
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"                   \
		-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE  \
		-DCMAKE_C_FLAGS:STRING="-m$BITS"             

	cmake --build . --config $BUILD_TYPE$BITS

	cd ../../

	create_dir bin/$3/$BUILD_TYPE/GoogleTestRunner/
	cp -f $BUILD_DIR/gtest-runner   bin/$3/$BUILD_TYPE/GoogleTestRunner/

	clear_build_dir
}

build 32 Debug   x86
build 32 Release x86
build 64 Debug   x86_64
build 64 Release x86_64

