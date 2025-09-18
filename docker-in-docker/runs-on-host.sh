#!/usr/bin/env bash
#
# This is designed to run on the host (Linux of Linux VM). Build and run a Docker container that itself builds and runs
# a Docker container.

set -e

echo "(host) Hello from $(hostname)" > log.txt

echo "(host) Building the first-level Docker image..."
docker build --file Dockerfile.first-level --tag docker-playground/docker-in-docker-first-level:local --quiet .

# Clean up any previous runs
docker rm -f first-level-container >/dev/null 2>&1 || true

echo "(host) Running the first-level Docker container..."
# Notice we are using --privileged flag. This is required for the container to run its own Docker daemon.
# I'm also not using --rm flag so we can inspect the container after it exits, for debugging.
docker run --privileged \
  --detach \
  --name first-level-container \
  --mount type=bind,source="$PWD",target=/app \
  docker-playground/docker-in-docker-first-level:local

echo "(host) Running the script inside the first-level Docker container..."
docker exec first-level-container /app/runs-on-first-level-container.sh

echo "(host) Stopping the first-level Docker container..."
docker stop first-level-container

echo "(host) Complete! Check the log.txt file to see what happened."
