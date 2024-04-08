#!/bin/bash

# Check if a filename has been provided
if [ -z "$1" ]; then
    echo "No file specified."
    exit 1
fi

# Extract the filename from the path
filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# Define the input and output paths
input_path="/data/$1"
output_directory="/output"

# Ensure the output directory exists
mkdir -p $output_directory

# Execute the conversion
/opt/2gltf2/2gltf2.sh "$input_path"

# Check if the .gltf file has been created successfully
if [ $? -eq 0 ]; then
    # Move the .gltf file to the output directory
    mv "/data/${filename}.gltf" "$output_directory/${filename}.gltf"
    echo "Conversion successful. Output file located at $output_directory/${filename}.gltf"
else
    echo "Conversion failed."
    exit 1
fi
