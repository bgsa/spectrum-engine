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

cmake --build . --config %BUILD_TYPE%

if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.pdb" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.pdb"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw.pdb"  DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw.pdb"

copy "src\glfw.dir\%BUILD_TYPE%\glfw.pdb"    "%OUTPUT_DIR%\%BUILD_TYPE%"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )


SET BUILD_TYPE=Release

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

cmake --build . --config %BUILD_TYPE%

if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )




SET ARCH_BITS=64
SET BUILD_DIR=glfw\build
SET BUILD_TYPE=Debug
SET SHARED_LIB=OFF
SET OUTPUT_DIR=%~dp0%lib\x86_64

mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"                          ^
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF                                 ^
	-DGLFW_BUILD_TESTS:BOOL=OFF                                    ^
	-DGLFW_BUILD_DOCS:BOOL=OFF                                     ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON                         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config %BUILD_TYPE%

if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.pdb" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.pdb"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw.pdb"  DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw.pdb"

copy "src\glfw.dir\%BUILD_TYPE%\glfw.pdb"    "%OUTPUT_DIR%\%BUILD_TYPE%"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )


SET BUILD_TYPE=Release

mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"                          ^
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF                                 ^
	-DGLFW_BUILD_TESTS:BOOL=OFF                                    ^
	-DGLFW_BUILD_DOCS:BOOL=OFF                                     ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON                         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config %BUILD_TYPE%

if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.dll"
if EXIST "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk" DEL /F "%OUTPUT_DIR%\%BUILD_TYPE%\glfw3.ilk"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )