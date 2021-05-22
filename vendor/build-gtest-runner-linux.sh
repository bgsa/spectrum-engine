#!/bin/bash

source ../build-base-linux.sh

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

if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86
	build 32 Release x86
fi

build 64 Debug   x86_64
build 64 Release x86_64

