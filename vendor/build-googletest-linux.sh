#!/bin/bash

set echo off

export BUILD_DIR=googletest/build

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                  \
	-DBUILD_SHARED_LIBS:BOOL=OFF              \
	-DCMAKE_BUILD_TYPE:STRING=Release         \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON

cmake --build . --config Release


cd ../../

cp $BUILD_DIR/lib/libgtest.a        ./lib
cp $BUILD_DIR/lib/libgtest_main.a   ./lib

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi