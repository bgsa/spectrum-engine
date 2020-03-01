@echo off 

SET BUILD_DIR=glfw\build
SET BUILD_TYPE=Release
SET SHARED_LIB=OFF

if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )
mkdir %BUILD_DIR%
cd %BUILD_DIR%

cmake .. -G "Visual Studio 15 2017 Win64"     ^
	-DGLFW_BUILD_EXAMPLES:BOOL=OFF            ^
	-DGLFW_BUILD_TESTS:BOOL=OFF               ^
	-DGLFW_BUILD_DOCS:BOOL=OFF                ^
	-DBUILD_SHARED_LIBS:BOOL=%SHARED_LIB%     ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON            ^
	-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=OFF

cmake --build . --config %BUILD_TYPE%

if %SHARED_LIB%==OFF   ( copy ".\src\%BUILD_TYPE%\glfw3.lib" "..\..\lib" )

if %SHARED_LIB%==ON    ( copy ".\src\%BUILD_TYPE%\glfw3dll.lib" "..\..\lib" )
if %SHARED_LIB%==ON    ( copy ".\src\%BUILD_TYPE%\glfw3.dll" "..\..\lib" )

if %BUILD_TYPE%==Debug ( copy ".\src\glfw.dir\%BUILD_TYPE%\glfw3.pdb" "..\..\lib" )
if %BUILD_TYPE%==Debug ( copy ".\src\glfw.dir\%BUILD_TYPE%\glfw3dll.exp" "..\..\lib" )
if %BUILD_TYPE%==Debug ( copy ".\src\glfw.dir\%BUILD_TYPE%\glfw3.ilk" "..\..\lib" )

cd ..\..\
if exist %BUILD_DIR% ( rmdir /s/q %BUILD_DIR% )