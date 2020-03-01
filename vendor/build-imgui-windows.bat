@echo off 

SET BUILD_DIR=imgui\build
SET BUILD_TYPE=Release
SET SHARED_LIB=OFF

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"     ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_BUILD_TYPE:STRING=%BUILD_TYPE%    ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DOPERATING_SYSTEM:STRING=WINDOWS

cmake --build . --config %BUILD_TYPE%

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )