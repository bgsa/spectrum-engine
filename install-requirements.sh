#!/bin/bash
# Linux requirements

set echo off

sudo apt-get update

sudo apt-get install -y gcc-multilib g++-multilib libx11-dev build-essential cmake

sudo apt-get install libgl1-mesa-glx:amd64 libgl1-mesa-dri:amd64

sudo apt-get install -y xserver-xorg-core xorg-dev mesa-utils mesa-common-dev libglew-dev libglfw3-dev