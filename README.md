# Docker Cleanup Script

This script provides a safe and comprehensive way to clean up Docker resources, including containers, images, networks, and volumes. It is designed to be used primarily in development environments where you may need to reclaim disk space and remove unused resources.

## Features

- Stops all running Docker containers.
- Removes stopped containers.
- Removes unused images.
- Removes unused networks.
- Removes dangling volumes.
- Optionally removes all volumes and images with user confirmation.

## Usage

1. **Save the Script**:
   
   Save the script to a file, e.g., `docker_cleanup.sh`.

2. **Make the Script Executable**:
   
   Run the following command to make the script executable:

   ```bash
   chmod +x docker_cleanup.sh
