#!/usr/bin/env bash
# Build the Docker image

if [[ ! -f tmp/jq ]]; then
  echo >&2 "'tmp/jq/' does not exist. You must download 'jq' manually and place it under 'tmp/'. See the README for instructions."
  exit 1
fi

chmod +x tmp/jq

DOCKER_BUILDKIT=1 docker build -t jq-echo .
