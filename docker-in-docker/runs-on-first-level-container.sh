#!/bin/sh
# This is designed to run in the 'first level' container. It builds and runs its own Docker container.

echo "Hello from $(hostname)" >> /app/log.txt

echo "Waiting for Docker daemon to be ready..."
i=1
while [ $i -le 30 ]; do
    if docker version >/dev/null 2>&1; then
        echo "Docker daemon is ready!"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "Docker daemon failed to start within 30 seconds"
        exit 1
    fi
    echo "Attempt $i/30..."
    sleep 1
    i=$((i + 1))
done

docker build --file /app/Dockerfile.nested --tag docker-playground-docker-in-docker-nested /app

docker run --rm --mount type=bind,source=/app,target=/app docker-playground-docker-in-docker-nested
