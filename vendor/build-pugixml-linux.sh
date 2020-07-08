#!/bin/bash

set echo off

export current_dir=$(pwd)
OS=$(uname -s)

build()
{
	export ARCH_BITS=$1
	export BUILD_TYPE=$2
	export OUTPUT_DIR=$current_dir/lib/$3/$BUILD_TYPE
	export BUILD_DIR=pugixml/build
	export SHARED_LIB=$4

	if [ -d $BUILD_DIR ]; then
		rm -rf $BUILD_DIR
	fi

	mkdir $BUILD_DIR
	cd $BUILD_DIR

	cmake .. -G "Unix Makefiles"                                \
		-DCMAKE_ENABLE_EXPORTS:BOOL=ON                      \
		-DBUILD_SHARED_LIBS:BOOL=$SHARED_LIB                \
		-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING=$OUTPUT_DIR \
		-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING=$OUTPUT_DIR

	cmake --build . --config $BUILD_TYPE$1

	cd ../

	if [ -d $BUILD_DIR ]; then
		rm -rf $BUILD_DIR
	fi

	cd ../include

	if [ -d pugixml ]; then
		rm -rf pugixml
	fi

	mkdir pugixml
	cp ../pugixml/src/*.hpp    pugixml

	cd ../

}

if [ "$OS" != "Darwin" ]; then
	build 32 Debug   x86    OFF
	build 32 Release x86    OFF
fi

build 64 Debug   x86_64 OFF
build 64 Release x86_64 OFF

