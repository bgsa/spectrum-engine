cd vendor
call .\build-glfw-windows.bat
call .\build-imgui-windows.bat

cd ..\sp-foundation
call .\build-windows.bat

cd ..\sp-physics
call .\build-windows.bat

cd ..\sp-frontend
call .\build-windows.bat