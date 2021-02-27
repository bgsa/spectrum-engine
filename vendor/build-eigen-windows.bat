@echo off

set OUTPUT_DIR=include\eigen\

if exist %OUTPUT_DIR% ( rmdir /s/q %OUTPUT_DIR% )
mkdir %OUTPUT_DIR%

xcopy "eigen\Eigen\" "%OUTPUT_DIR%" /e /y


set OUTPUT_DIR=include\eigen\unsupported

if exist %OUTPUT_DIR% ( rmdir /s/q %OUTPUT_DIR% )
mkdir %OUTPUT_DIR%

xcopy "eigen\unsupported" "%OUTPUT_DIR%" /e /y