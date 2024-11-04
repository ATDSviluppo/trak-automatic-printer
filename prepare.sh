#!/bin/bash

# Step 0: Clean up the target directory
echo "Cleaning up target directory..."
if [ -d ~/Workspace/trak-automatic-printer/target ]; then
    rm -r ~/Workspace/trak-automatic-printer/target/*
else
    echo "Target directory does not exist, nothing to clean up."
fi

# Step 1: Check if the container already exists and remove it
if podman ps -a --format '{{.Names}}' | grep -q 'trak_aprinter'; then
    echo "Removing existing container 'trak_aprinter'..."
    podman rm -f trak_aprinter
fi

# Step 2: Create and run the Ubuntu 24.10 container with Podman
echo "Creating and starting the Ubuntu 24.10 container..."
podman run --name trak_aprinter -d ubuntu:24.10 tail -f /dev/null

# Step 3: Install necessary packages (libssl-dev, build-essential, and curl)
echo "Installing necessary packages..."
podman exec trak_aprinter apt-get update -y && \
podman exec trak_aprinter apt-get install -y libssl-dev build-essential musl musl-dev musl-tools curl

# Step 4: Install Rust
echo "Installing Rust..."
podman exec trak_aprinter bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# Step 5: Add the MUSL target for Rust
echo "Adding the MUSL target for Rust..."
podman exec trak_aprinter bash -c "source /root/.cargo/env && rustup target add x86_64-unknown-linux-musl"

# Step 6: Create the /source and /openssl directories in the container and copy project files
echo "Copying source files and OpenSSL 1.1.1 to container..."
podman cp ~/Workspace/trak-automatic-printer trak_aprinter:/source
podman cp ~/Workspace/openssl-1.1.1w trak_aprinter:/openssl

# Step 7: Source the Rust environment again and run the build.sh script inside the container
echo "Running build script inside the container..."
podman exec trak_aprinter bash -c "source /root/.cargo/env && cd /source && ./build.sh"

# Step 8: Copy the built binary from the container to the host
echo "Copying built binary from the container to the host..."
podman cp trak_aprinter:/source/target/x86_64-unknown-linux-musl/release/trak-automatic-printer ~/Workspace/trak-automatic-printer/target

echo "Container setup complete, OpenSSL project copied, and build.sh script executed. The binary has been copied to ~/Workspace/trak-automatic-printer/target."

# Step 9: Stop the container
echo "Stopping the container..."
podman stop trak_aprinter
