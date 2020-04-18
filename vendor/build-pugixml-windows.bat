@echo off

SET ARCH_BITS=32
SET BUILD_DIR=pugixml\build
SET SHARED_LIB=OFF
SET OUTPUT_DIR=%~dp0%lib\x86

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017"                                ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config Debug

copy "Debug\pugixml.pdb"    "%OUTPUT_DIR%\Debug"

cmake --build . --config Release

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

SET OUTPUT_DIR=%OUTPUT_DIR%_64

cmake .. -G "Visual Studio 15 2017 Win64"                          ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config Debug

copy "Debug\pugixml.pdb"    "%OUTPUT_DIR%\Debug"

cmake --build . --config Release

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )


cd include
if exist pugixml ( rmdir /s/q pugixml )
mkdir pugixml
copy "..\pugixml\src\*.hpp"    "pugixml"

:END