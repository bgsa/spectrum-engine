#!/bin/bash

set echo off
export current_dir=$(dirname $0)


export ARCH_BITS=32
export OUTPUT_DIR=$current_dir/lib/x86
export BUILD_DIR=pugixml\build
export BUILD_TYPE=Debug
export SHARED_LIB=OFF

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

cmake --build . --config $BUILD_TYPE

cp "Debug\pugixml.pdb"    "$OUTPUT_DIR\Debug"

cd ../

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

cd include
if [ -d pugixml ]; then
	rm -rf pugixml
fi
mkdir pugixml
cp "../pugixml/src/*.hpp"    "pugixml"
