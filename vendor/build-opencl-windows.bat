@echo off

SET EXAMPLE="build-opencl-windows.bat  32|64"

IF %1.==. GOTO Param1NotFound

SET ARCH_BITS=%1
SET BUILD_DIR=OpenCL-ICD-Loader\build
SET BUILD_TYPE=Release
SET SHARED_LIB=ON
SET OUTPUT_DIR=%~dp0%lib\x86
SET VS_PARAMETER=Win32

IF %1==64 (
	SET OUTPUT_DIR=%OUTPUT_DIR%_64
	SET VS_PARAMETER=Win64
)

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017" -A %VS_PARAMETER%              ^
	-DWIN32:BOOL=ON                                                ^
	-D_WIN32:BOOL=ON                                               ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
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

GOTO END

:Param1NotFound
	echo Parameter ArchBits not provided.  %EXAMPLE%
	GOTO END

:END