#!/bin/bash

# Check if directory provided as argument
if [ -n "$1" ]; then
    PROJECT_DIR="$1"
else
    echo "Enter the path to your project directory (or press Enter for current directory):"
    read -r PROJECT_DIR
    
    # Default to current directory if empty
    if [ -z "$PROJECT_DIR" ]; then
        PROJECT_DIR="$(pwd)"
    fi
fi

# Expand tilde to home directory if present
PROJECT_DIR="${PROJECT_DIR/#\~/$HOME}"

# Check if directory exists
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Directory '$PROJECT_DIR' does not exist."
    exit 1
fi

echo "Starting Avalonia dev container (with Android SDK) with:"
echo "  Project: $PROJECT_DIR -> /workspace"
echo ""

podman run -it \
  -v "$PROJECT_DIR:/workspace" \
  avalonia-dev-full
