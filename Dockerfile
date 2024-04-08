# Use an Ubuntu base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including xz-utils for handling .tar.xz files, Blender dependencies, common X11 libraries, and OpenGL libraries
RUN apt-get update && apt-get install -y \
    curl \
    libxi6 \
    libxrender1 \
    libglu1-mesa \
    libxkbcommon0 \
    git \
    xz-utils \
    libxxf86vm1 \
    libxfixes3 \
    libsm6 \
    libice6 \
    libdbus-1-3 \
    libxrandr2 \
    libgl1-mesa-glx \ 
    libgl1 \  
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

# Copy the entrypoint script into the container
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint script to be executed when the container starts
ENTRYPOINT ["docker-entrypoint.sh"]
