#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 filename [output_path]"
    echo "filename: Name of the file to convert. Must be located in /data directory."
    echo "output_path: Optional. The path where the output files will be stored relative to /data. Defaults to /data/output."
}

# Check if a filename has been provided or if help is requested
if [ -z "$1" ] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    usage
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

# Default output directory inside the container
output_dir="/data/output"

# If a second argument is provided and it does not start with "/data", prepend "/data"
if [ ! -z "$2" ]; then
    if [[ "$2" == /data* ]]; then
        output_dir="$2"
    else
        output_dir="/data/$2"
    fi
fi

# Ensure the output directory exists
mkdir -p "$output_dir/$filename"

# Move the entire output directory to the specified or default output directory
mv "/opt/2gltf2/$filename" "$output_dir/"

echo "Check $output_dir/$filename for the output files."
