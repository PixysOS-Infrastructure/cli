#!/bin/bash

# Check if both version and hash are defined
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <version> <hash>"
    exit 1
fi

# Define the version and hash
VERSION=$1
HASH=$2

# Check if the system is Linux
if [[ $(uname) != "Linux" ]]; then
    echo "Error: This script only supports Linux systems."
    exit 1
fi

# Get the system architecture
ARCH=$(dpkg --print-architecture)
if [[ "$ARCH" != "amd64" && "$ARCH" != "arm64" ]]; then
    echo "Error: Unsupported architecture. Only amd64 and arm64 are supported."
    exit 1
fi

# Define the GitHub release URL
URL="https://github.com/PixysOS-Infrastructure/cli/releases/download/release%2F${VERSION}/pixys.cli.${VERSION}.${HASH}.${ARCH}"

# Define the local bin directory
BIN_DIR="$HOME/.local/bin"

# Create the directory if it doesn't exist
mkdir -p "$BIN_DIR"

# Download the release binary
echo "Downloading ${URL}..."
if ! curl -L "${URL}" -o "${BIN_DIR}/pixys-cli"; then
    echo "Error: Failed to download the release binary."
    exit 1
fi

# Give executable permission
chmod +x "${BIN_DIR}/pixys-cli"

echo "Pixys CLI has been installed successfully to ${BIN_DIR}"
