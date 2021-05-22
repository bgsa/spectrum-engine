#!/bin/bash

set echo off

export BUILD_DIR=build
export current_dir=$(pwd)
export OS=$(uname -s)

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