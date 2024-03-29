@echo off 

SET BUILD_DIR=imgui\build
SET SHARED_LIB=OFF
SET BUILD_TYPE=Debug

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017"           ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_BUILD_TYPE:STRING=%BUILD_TYPE%          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DOPERATING_SYSTEM:STRING=WINDOWS         ^
	-DOUTPUT_LIB_DIR:STRING=..\..\lib\x86\

cmake --build . --config %BUILD_TYPE%

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )


SET BUILD_TYPE=Release
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017"           ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_BUILD_TYPE:STRING=%BUILD_TYPE%          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DOPERATING_SYSTEM:STRING=WINDOWS         ^
	-DOUTPUT_LIB_DIR:STRING=..\..\lib\x86\

cmake --build . --config %BUILD_TYPE%

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )



SET BUILD_TYPE=Debug
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"           ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_BUILD_TYPE:STRING=%BUILD_TYPE%          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DOPERATING_SYSTEM:STRING=WINDOWS         ^
	-DOUTPUT_LIB_DIR:STRING=..\..\lib\x86_64\

cmake --build . --config %BUILD_TYPE%

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )


SET BUILD_TYPE=Release

mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"           ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_BUILD_TYPE:STRING=%BUILD_TYPE%          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DOPERATING_SYSTEM:STRING=WINDOWS         ^
	-DOUTPUT_LIB_DIR:STRING=..\..\lib\x86_64\

cmake --build . --config %BUILD_TYPE%

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )



cd include
if exist imgui ( rmdir /s/q imgui )
mkdir imgui
copy "..\imgui\*.h"   "imgui\"

cd ..\
