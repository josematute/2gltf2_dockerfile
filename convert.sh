#!/bin/bash

# Check if a filename has been provided
if [ -z "$1" ]; then
    echo "No file specified."
    exit 1
fi

# Full path of the input file within the container
input_file="/data/$1"

# Extract the filename without the path
filename=$(basename -- "$1")
filename="${filename%.*}"

# Change to the script's directory
cd /opt/2gltf2

# Execute the conversion
./2gltf2.sh "$input_file"

# Move the GLTF file to the output directory
mv "/opt/2gltf2/$filename/$filename.gltf" "/data/output/$filename.gltf"

# No need to move the file, assuming the script outputs to the same directory as the input file
echo "Check the current directory for the output file."
