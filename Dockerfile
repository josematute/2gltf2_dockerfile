# Use an Ubuntu base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including xz-utils for handling .tar.xz files
RUN apt-get update && apt-get install -y \
    curl \
    libxi6 \
    libxrender1 \
    libglu1-mesa \
    libxkbcommon0 \
    git \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Set the Blender version and URL
ARG BLENDER_URL="https://download.blender.org/release/Blender3.5/blender-3.5.1-linux-x64.tar.xz"

# Download and extract Blender
RUN curl -L $BLENDER_URL | tar -xJ -C /opt

# Find the Blender directory and make a symbolic link to the executable
RUN ln -s /opt/blender-3.5.1-linux-x64/blender /usr/local/bin/blender

# Clone the 2gltf2 repository
RUN git clone https://github.com/viusbuilt/2gltf2.git /opt/2gltf2

# Make the conversion script executable
RUN chmod +x /opt/2gltf2/2gltf2.sh

# Add 2gltf2 to PATH
ENV PATH="/opt/2gltf2:${PATH}"

# Set work directory to /data which is a good practice for Docker containers
WORKDIR /data

# Default to bash
CMD ["/bin/bash"]
