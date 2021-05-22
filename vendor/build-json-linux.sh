#!/bin/bash

source ../build-base-linux.sh

export OUTPUT_DIR=include/nlohmann/

if [ -d $OUTPUT_DIR ]; then
    rm -rf $OUTPUT_DIR
fi

mkdir -p "$OUTPUT_DIR"

cp -R "json/include/nlohmann/" "include"