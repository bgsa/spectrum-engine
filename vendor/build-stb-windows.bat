@echo off

set OUTPUT_DIR=.\include\stb

if exist %OUTPUT_DIR% ( rmdir /s/q %OUTPUT_DIR% )
mkdir %OUTPUT_DIR%

copy ".\stb\stb_image.h"        "%OUTPUT_DIR%"
copy ".\stb\stb_image_resize.h" "%OUTPUT_DIR%"
copy ".\stb\stb_image_write.h"  "%OUTPUT_DIR%"