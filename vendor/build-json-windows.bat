@echo off

set OUTPUT_DIR=include\nlohmann\

if exist %OUTPUT_DIR% ( rmdir /s/q %OUTPUT_DIR% )
mkdir %OUTPUT_DIR%

xcopy "json\include\nlohmann\" "%OUTPUT_DIR%" /e /y
