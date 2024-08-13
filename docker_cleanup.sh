#!/bin/bash

# Function to confirm action
confirm() {
    echo "$1"
    read -p "Are you sure you want to continue? (y/n): " choice
    case "$choice" in
        y|Y ) ;;
        * ) echo "Operation canceled."; exit 1;;
    esac
}

# Stop all running containers
echo "Stopping all running containers..."
docker ps -q | xargs -r docker stop

# Remove all stopped containers
echo "Removing all stopped containers..."
docker container prune -f

# Remove all unused images
echo "Removing all unused images..."
docker image prune -a -f

# Remove all unused networks
echo "Removing all unused networks..."
docker network prune -f

# Remove all dangling volumes
echo "Removing all dangling volumes..."
docker volume prune -f

# Optionally, remove all volumes (use with caution)
confirm "This will remove all volumes. Data stored in volumes will be lost."
echo "Removing all volumes..."
docker volume ls -q | xargs -r docker volume rm

# Optionally, remove all images (use with caution)
confirm "This will remove all images. Ensure you don't need any of these images."
echo "Removing all images..."
docker images -q | xargs -r docker rmi -f

echo "Docker cleanup complete."
