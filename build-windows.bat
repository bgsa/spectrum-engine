cd vendor
call .\build-glew-windows.bat
call .\build-opencl-windows.bat
call .\build-glfw-windows.bat
call .\build-json-windows.bat
call .\build-stb-windows.bat
call .\build-pugixml-windows.bat
call .\build-imgui-windows.bat
call .\build-googletest-windows.bat

cd ..\sp-foundation
call .\build-windows.bat

cd ..\sp-physics
call .\build-windows.bat

cd ..\sp-rendering
call .\build-windows.bat

cd ..\sp-frontend
call .\build-windows.bat

cd ..