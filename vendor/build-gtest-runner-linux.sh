#!/bin/bash

set echo off

export BUILD_DIR=gtest-runner/build

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                             \
	-DCMAKE_BUILD_TYPE:STRING=Release   \
	-DCMAKE_C_FLAGS:STRING="-m32"             

cmake --build . --config Release

cd ../../

cp $BUILD_DIR/gtest-runner   bin/x86/GoogleTestRunner

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake .. -G "Unix Makefiles"                             \
	-DCMAKE_BUILD_TYPE:STRING=Release   \
	-DCMAKE_C_FLAGS:STRING="-m64"

cmake --build . --config Release

cd ../../

cp $BUILD_DIR/gtest-runner   bin/x86_64/GoogleTestRunner

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi