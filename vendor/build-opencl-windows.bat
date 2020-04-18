@echo off

SET BUILD_DIR=OpenCL-ICD-Loader\build
SET BUILD_TYPE=Release
SET OUTPUT_DIR=%~dp0%lib\x86

rem Building OpenCL x86 (Debug and Release)
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017"                                ^
	-DWIN32:BOOL=ON                                                ^
	-D_WIN32:BOOL=ON                                               ^
	-DBUILD_SHARED_LIBS:BOOL=ON                                    ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DOPENCL_ICD_LOADER_REQUIRE_WDK=OFF                            ^
	-DOPENCL_ICD_LOADER_HEADERS_DIR="%~dp0%OpenCL-Headers"         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config Release

cmake --build . --config Debug

copy "Debug\*.*"    "%OUTPUT_DIR%\Debug\"
copy "Release\*.*"  "%OUTPUT_DIR%\Release\"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )



rem Building OpenCL x64 (Debug and Release)
SET OUTPUT_DIR=%~dp0%lib\x86_64

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"                                ^
	-DWIN32:BOOL=ON                                                ^
	-D_WIN32:BOOL=ON                                               ^
	-DBUILD_SHARED_LIBS:BOOL=ON                                    ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DOPENCL_ICD_LOADER_REQUIRE_WDK=OFF                            ^
	-DOPENCL_ICD_LOADER_HEADERS_DIR="%~dp0%OpenCL-Headers"         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config Release

cmake --build . --config Debug

copy "Debug\*.*"    "%OUTPUT_DIR%\Debug\"
copy "Release\*.*"  "%OUTPUT_DIR%\Release\"

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
