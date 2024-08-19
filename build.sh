#!/bin/bash

# Input:
# 1: build type{Debug | Release}
if [ "$#" -eq 0 ]; then
    BUILD_TYPE="Debug"
else
    BUILD_TYPE="$1"
fi

case "$BUILD_TYPE" in
    Debug)
        ;;
    Release)
        ;;
    *)
        echo "Invalid build type."
        exit 1
        ;;
esac

mkdir -p build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE="$BUILD_TYPE"
make -j64
cd ..
