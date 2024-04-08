#!/bin/bash
# docker-entrypoint.sh

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "To glTF 2.0 converter."
    echo "Supported file formats: .abc .blend .dae .fbx. .obj .ply .stl .usd .wrl .x3d"
    echo 
    echo "2gltf2.sh [filename]"
fi

# Run the 2gltf2 conversion script with all arguments passed to this script
/opt/2gltf2/2gltf2.sh "$@"
