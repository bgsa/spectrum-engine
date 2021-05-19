#!/bin/bash

# Linux requirements

set echo off

sudo dpkg --add-architecture i386

sudo apt-get dist-upgrade

sudo apt-get install -y ia32-libs

sudo apt-get install -y gcc-multilib g++-multilib cmake libx11-dev libx11-dev:i386 libxext-dev:i386 libxmu-dev:i386 libxi-dev:i386

sudo apt-get install -y build-essential build-essential:i386

sudo apt-get install libgl1-mesa-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-glx:amd64 libgl1-mesa-dri:i386 libgl1-mesa-dri:amd64 xserver-xorg-core

sudo apt-get install -y xorg-dev

sudo apt-get install -y mesa-utils mesa-utils:i386 mesa-common-dev mesa-common-dev:i386

sudo apt-get install -y libglew-dev

sudo apt-get install -y libglfw3-dev

sudo apt-get install -y qt5-default libqt5xmlpatterns5-dev