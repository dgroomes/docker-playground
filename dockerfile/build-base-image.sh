#!/usr/bin/env bash
# Build a Docker image that contains 'jq'. This will serve as a base image for other images to build on top of.

if [[ ! -f tmp/jq ]]; then
  echo >&2 "'tmp/jq' does not exist. You must download 'jq' manually and place it under 'tmp/'. See the README for instructions."
  exit 1
fi

chmod +x tmp/jq

# In the latest versions of Docker, BuildKit is enabled by default when using Docker Desktop. However, let's be explicit.
DOCKER_BUILDKIT=1 docker build --tag docker-playground/jq .
