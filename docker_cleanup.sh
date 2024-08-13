#!/bin/bash

set -e

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
if docker ps -q | xargs -r docker stop; then
    echo "Stopped all running containers."
else
    echo "No containers were stopped."
fi

# Remove all stopped containers
echo "Removing all stopped containers..."
if docker container prune -f; then
    echo "Removed all stopped containers."
else
    echo "Failed to remove stopped containers."
fi

# Remove all unused images
echo "Removing all unused images..."
if docker image prune -a -f; then
    echo "Removed all unused images."
else
    echo "Failed to remove unused images."
fi

# Remove all unused networks
echo "Removing all unused networks..."
if docker network prune -f; then
    echo "Removed all unused networks."
else
    echo "Failed to remove unused networks."
fi

# Remove all dangling volumes
echo "Removing all dangling volumes..."
if docker volume prune -f; then
    echo "Removed all dangling volumes."
else
    echo "Failed to remove dangling volumes."
fi

# Optionally, remove all volumes (use with caution)
confirm "This will remove all volumes. Data stored in volumes will be lost."
echo "Removing all volumes..."
if docker volume ls -q | xargs -r docker volume rm; then
    echo "Removed all volumes."
else
    echo "Failed to remove volumes."
fi

# Optionally, remove all images (use with caution)
confirm "This will remove all images. Ensure you don't need any of these images."
echo "Removing all images..."
if docker images -q | xargs -r docker rmi -f; then
    echo "Removed all images."
else
    echo "Failed to remove images."
fi

echo "Docker cleanup complete."
