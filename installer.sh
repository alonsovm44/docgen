#!/bin/bash
set -e

echo "Checking for prerequisites..."
if ! command -v curl &> /dev/null; then
    echo "Warning: curl not found. docgen requires curl to make API requests."
fi

echo "Compiling docgen..."
if command -v g++ &> /dev/null; then
    echo "Using g++..."
    g++ -std=c++17 -o docgen src/main.cpp
elif command -v clang++ &> /dev/null; then
    echo "Using clang++..."
    clang++ -std=c++17 -o docgen src/main.cpp
else
    echo "Error: No C++ compiler found. Please install g++ or clang++."
    exit 1
fi

if [ -f docgen ]; then
    echo "Build complete. Run ./docgen to start."
else
    echo "Build failed."
    exit 1
fi