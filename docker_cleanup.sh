#!/bin/bash

set -e

# Trap for handling script interruption
trap 'echo "Operation interrupted. Exiting..." && exit 1' INT TERM

# Function to confirm action
confirm() {
    echo "$1"
    read -p "Are you sure you want to continue? (y/n): " choice
    case "$choice" in
        y|Y ) ;;
        * ) echo "Operation canceled."; exit 1;;
    esac
}

echo "Starting Docker cleanup..."

# Stop all running containers
echo "Stopping all running containers..."
docker ps -q | xargs -r docker stop || { echo "No running containers to stop."; }

# Remove all stopped containers, images, unused networks, and dangling volumes
echo "Performing general cleanup..."
docker system prune -a -f --volumes || { echo "Failed to perform general cleanup."; exit 1; }

# Optionally remove all volumes (including those in use, use with caution)
confirm "This will remove ALL volumes, including ones in use. Data stored in volumes will be lost."
docker volume ls -q | xargs -r docker volume rm || { echo "Failed to remove all volumes."; exit 1; }

# Optionally remove all images
confirm "This will remove ALL images. Ensure you don't need any of these images."
docker images -q | xargs -r docker rmi -f || { echo "Failed to remove all images."; exit 1; }

echo "Docker cleanup complete."
