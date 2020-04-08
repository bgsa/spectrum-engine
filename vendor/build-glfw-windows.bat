@echo off

SET EXAMPLE="build-glfw-windows.bat  32|64  Debug|Release  Static|Dynamic"

IF %1.==. GOTO Param1NotFound
IF %2.==. GOTO Param2NotFound
IF %3.==. GOTO Param3NotFound

SET ARCH_BITS=%1
SET BUILD_DIR=glfw\build
SET BUILD_TYPE=%2
SET SHARED_LIB=OFF
SET OUTPUT_DIR=%~dp0%lib\x86
SET VS_PARAMETER=

IF %1==64 (
	SET OUTPUT_DIR=%OUTPUT_DIR%_64
	SET VS_PARAMETER= Win64
)

if %3==Dynamic (
	SET SHARED_LIB=ON
)

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017%VS_PARAMETER%"                 ^
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF                                 ^
	-DGLFW_BUILD_TESTS:BOOL=OFF                                    ^
	-DGLFW_BUILD_DOCS:BOOL=OFF                                     ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%                          ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON                                 ^
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON                         ^
	-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"         ^
	-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:STRING="%OUTPUT_DIR%"

cmake --build . --config %BUILD_TYPE%

if %BUILD_TYPE%==Debug (
	if EXIST "%OUTPUT_DIR%\Debug\glfw3.dll" DEL /F "%OUTPUT_DIR%\Debug\glfw3.dll"
	if EXIST "%OUTPUT_DIR%\Debug\glfw3.ilk" DEL /F "%OUTPUT_DIR%\Debug\glfw3.ilk"
	if EXIST "%OUTPUT_DIR%\Debug\glfw3.pdb" DEL /F "%OUTPUT_DIR%\Debug\glfw3.pdb"
	if EXIST "%OUTPUT_DIR%\Debug\glfw.pdb"  DEL /F "%OUTPUT_DIR%\Debug\glfw.pdb"

	if %SHARED_LIB%==ON (
		copy "src\Debug\glfw3.dll"    "%OUTPUT_DIR%\Debug"
		copy "src\Debug\glfw3.pdb"    "%OUTPUT_DIR%\Debug"
		copy "src\Debug\glfw3.ilk"    "%OUTPUT_DIR%\Debug"
	) else (
		copy "src\glfw.dir\Debug\glfw.pdb"    "%OUTPUT_DIR%\Debug"
	)
) else (
	if %SHARED_LIB%==ON (
		copy "src\Release\glfw3.dll"   "%OUTPUT_DIR%\Release"
	)
)

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )

GOTO END

:Param1NotFound
	echo Parameter ArchBits not provided.  %EXAMPLE%
	GOTO END
:Param2NotFound
	echo Parameter BuildType not provided. %EXAMPLE%
	GOTO END
:Param3NotFound
	echo Parameter LibraryType not provided. %EXAMPLE%
	GOTO END

:END