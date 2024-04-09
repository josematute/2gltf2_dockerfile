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

# Ensure the output directory exists in /data
mkdir -p "/data/output/$filename"

# Move the entire output directory to /data/output
# This will transfer all converted files and associated resources
mv "/opt/2gltf2/$filename" "/data/output/"

echo "Check /data/output/$filename for the output files."
