#!/bin/bash

set echo off

export BUILD_DIR=googletest/build
export OUTPUT_DIR_32=lib/x86
export OUTPUT_DIR_64=lib/x86_64

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                             \
	-DBUILD_SHARED_LIBS:BOOL=OFF            \
	-DCMAKE_BUILD_TYPE:STRING=Release    \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON    \
	-DCMAKE_CXX_FLAGS="-fPIC"                    \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config Release

cd ../../

cp $BUILD_DIR/lib/libgtest.a            $OUTPUT_DIR_32 
cp $BUILD_DIR/lib/libgtest_main.a   $OUTPUT_DIR_32

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                             \
	-DBUILD_SHARED_LIBS:BOOL=OFF            \
	-DCMAKE_BUILD_TYPE:STRING=Release    \
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON    \
	-DCMAKE_CXX_FLAGS="-fPIC"                    \
	-DCMAKE_C_FLAGS:STRING="-m64"             

cmake --build . --config Release

cd ../../

cp $BUILD_DIR/lib/libgtest.a            $OUTPUT_DIR_64
cp $BUILD_DIR/lib/libgtest_main.a   $OUTPUT_DIR_64

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi