## Configuration Details¶

Ports: The service is made available on port 3000 of the host, allowing you to access Pingvin Share via http://your-host-ip:3000.
Volumes:
./data:/opt/app/backend/data: This volume mounts a host directory to the container where Pingvin Share stores its data files.
./data/images:/opt/app/frontend/public/img: This maps a subdirectory of the same host directory specifically for storing images used by the Pingvin Share frontend.
Preparing Volume Directories¶

Before deploying the service, it's essential to create the necessary directories on the host machine. This prevents Docker from automatically creating them with root ownership, which could lead to permission issues.

## Creating Directories¶

Run the following commands in the terminal to create the directories with the appropriate permissions:


mkdir -p ./data/images
mkdir -p ./data/images: Creates the data directory and the images subdirectory.
Deployment¶

Once the directories are prepared, you can deploy Pingvin Share using Docker Compose:


docker-compose up -d
This command starts the Pingvin Share service in detached mode, running in the background.

## Accessing Pingvin Share¶

After deployment, Pingvin Share will be accessible via http://your-host-ip:3000. You can start uploading and sharing files immediately through its web interface.