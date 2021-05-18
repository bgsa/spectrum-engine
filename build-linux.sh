
cd vendor/

./build-glew-linux.sh
./build-opencl-linux.sh
./build-glfw-linux.sh
./build-json-linux.sh
./build-pugixml-linux.sh
./build-stb-linux.sh
./build-imgui-linux.sh
./build-googletest-linux.sh
./build-gtest-runner-linux.sh

cd ../sp-foundation/
./build-linux.sh

cd ../sp-physics/
./build-linux.sh

cd ../sp-rendering/
./build-linux.sh

cd ../sp-frontend/
./build-linux.sh

cd ..
