@echo off 

cd glew-cmake\

rem Copying header files
copy "include\GL\*.h" "..\include\GL\"

cd build\cmake\

rem Building - x86 - Debug
if exist build ( rmdir /s/q build )
mkdir build
cd build

cmake .. -G "Visual Studio 15 2017"            ^
	-DBUILD_SHARED_LIBS:BOOL=OFF               ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON             ^
	-DBUILD_UTILS:BOOL=OFF

cmake --build . --target glew_s --config Debug

copy "lib\Debug\libglew32d.lib"    "..\..\..\..\lib\x86\Debug\glew32sd.lib"
copy "glew_s.dir\Debug\glew_s.pdb" "..\..\..\..\lib\x86\Debug\"

cd ..\
rmdir /s/q build


rem Building - x64 - Debug
mkdir build
cd build

cmake .. -G "Visual Studio 15 2017 Win64"      ^
	-DBUILD_SHARED_LIBS:BOOL=OFF               ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON             ^
	-DBUILD_UTILS:BOOL=OFF

cmake --build . --target glew_s --config Debug

copy "lib\Debug\libglew32d.lib"    "..\..\..\..\lib\x86_64\Debug\glew64sd.lib"
copy "glew_s.dir\Debug\glew_s.pdb" "..\..\..\..\lib\x86_64\Debug\"

cd ..\
rmdir /s/q build


rem Building - x86 - Release
mkdir build
cd build

cmake .. -G "Visual Studio 15 2017"            ^
	-DBUILD_SHARED_LIBS:BOOL=OFF               ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON             ^
	-DBUILD_UTILS:BOOL=OFF

cmake --build . --target glew_s --config Release

copy "lib\Release\libglew32.lib" "..\..\..\..\lib\x86\Release\glew32s.lib"

cd ..\
rmdir /s/q build


rem Building - x64 - Release
mkdir build
cd build

cmake .. -G "Visual Studio 15 2017 Win64"      ^
	-DBUILD_SHARED_LIBS:BOOL=OFF               ^
	-DCMAKE_ENABLE_EXPORTS:BOOL=ON             ^
	-DBUILD_UTILS:BOOL=OFF

cmake --build . --target glew_s --config Release

copy "lib\Release\libglew32.lib" "..\..\..\..\lib\x86_64\Release\glew64s.lib"

cd ..\
rmdir /s/q build


cd ..\..\..\