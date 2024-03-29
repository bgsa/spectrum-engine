#!/bin/bash

source ../build-base-linux.sh

build()
{
	export BUILD_DIR=googletest/build
	export BUILD_TYPE=$2
	export OUTPUT_DIR=lib/$3/$BUILD_TYPE/

	make_build_dir
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"                  \
		-DBUILD_SHARED_LIBS:BOOL=$4           \
		-DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON        \
		-DCMAKE_CXX_FLAGS="-fPIC"             \
		-DCMAKE_C_FLAGS:STRING="-m$1"             

	cmake --build . --config $BUILD_TYPE$1

	cd ../../

	create_dir $OUTPUT_DIR/
	cp -f $BUILD_DIR/lib/libgtest$5.a        $OUTPUT_DIR
	cp -f $BUILD_DIR/lib/libgtest_main$5.a   $OUTPUT_DIR

	clear_build_dir
}

if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86    OFF d
	build 32 Release x86    OFF
fi

build 64 Debug   x86_64 OFF d
build 64 Release x86_64 OFF


