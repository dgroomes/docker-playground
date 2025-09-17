#!/usr/bin/env bash
#
# This is designed to run on the host (Linux of Linux VM). Build and run a Docker container that itself builds and runs
# a Docker container.

set -e

echo "Hello from $(hostname)" > log.txt

docker build --file Dockerfile.first-level --tag docker-playground-docker-in-docker-first-level .

# Run the container. Notice we are using --privileged flag. This is required for the container to run its own Docker
# daemon.
docker run --privileged \
  --detach \
  --name first-level-container \
  --rm \
  --mount type=bind,source="$PWD",target=/app \
  docker-playground-docker-in-docker-first-level

docker exec first-level-container /app/runs-on-first-level-container.sh
docker stop first-level-container

echo "Complete! Check the log.txt file to see what happened."
