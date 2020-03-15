#!/bin/bash

# Linux requirements

set echo off

sudo dpkg --add-architecture i386

sudo apt-get install -y build-essential

sudo apt-get install -y gcc-multilib
sudo apt-get install -y g++-multilib

sudo apt-get install -y cmake

sudo apt-get install -y libx11-dev
sudo apt-get install -y libx11-dev:i386

sudo apt-get install -y xorg-dev

sudo apt-get install -y mesa-utils

sudo apt-get install -y libglew-dev

sudo apt-get install -y libglfw3-dev
