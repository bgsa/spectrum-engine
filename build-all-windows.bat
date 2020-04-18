call .\build-dependencies.bat

cd ..\sp-foundation
call .\build-windows.bat

cd ..\sp-physics
call .\build-windows.bat

cd ..\sp-rendering
call .\build-windows.bat

cd ..\sp-frontend
call .\build-windows.bat