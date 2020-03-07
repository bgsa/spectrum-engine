@echo off 

SET BUILD_DIR=googletest\build

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"     ^
	-DBUILD_SHARED_LIBS:BOOL=OFF              ^
	-DCMAKE_BUILD_TYPE:STRING=Release         ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DINSTALL_GTEST:BOOL=OFF                  ^
	-DBUILD_GMOCK:BOOL=OFF

cmake --build . --config Release

cd ..\..\

xcopy /y/s .\googletest\build\lib\Release\gtest.lib       .\lib
xcopy /y/s .\googletest\build\lib\Release\gtest_main.lib  .\lib

rem if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )