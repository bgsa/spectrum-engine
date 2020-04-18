@echo off

SET ARCH_BITS=32
SET BUILD_DIR=glfw\build
SET BUILD_TYPE=Debug
SET SHARED_LIB=OFF
SET OUTPUT_DIR=%~dp0%lib\x86
SET VS_PARAMETER=

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017"                                ^
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF                                 ^
	-DGLFW_BUILD_TESTS:BOOL=OFF                                    ^
	-DGLFW_BUILD_DOCS:BOOL=OFF                                     ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON                         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config Debug

if EXIST "%OUTPUT_DIR%\Debug\glfw3.dll" DEL /F "%OUTPUT_DIR%\Debug\glfw3.dll"
if EXIST "%OUTPUT_DIR%\Debug\glfw3.ilk" DEL /F "%OUTPUT_DIR%\Debug\glfw3.ilk"
if EXIST "%OUTPUT_DIR%\Debug\glfw3.pdb" DEL /F "%OUTPUT_DIR%\Debug\glfw3.pdb"
if EXIST "%OUTPUT_DIR%\Debug\glfw.pdb"  DEL /F "%OUTPUT_DIR%\Debug\glfw.pdb"

copy "src\glfw.dir\Debug\glfw.pdb"    "%OUTPUT_DIR%\Debug"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
