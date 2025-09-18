#!/bin/bash

set -e

# Docker-in-Docker (DinD) entrypoint script.
#
# This script was originally designed to set up an environment needed to run Docker inside Docker on a Debian based
# image. My original designed used lots of the configuration and practices of other DinD configurations:
#
# - https://github.com/docker-library/docker/tree/9ec9a719b2f803cb351c0db954f5653a4fd1d38c/28/dind
# - https://github.com/moby/moby/blob/af6d59ea486757853663bd1436d4c04dd549486f/hack/dind
# - https://github.com/devcontainers/features/tree/c05bd451518d73c9658eb9a41db18aaa968b73f3/src/docker-in-docker
#
# However, I've pruned it down to a single 'dockerd' command. Don't use what you don't need.

echo "(dind-entrypoint) Starting Docker daemon..."

dockerd --host=unix:///var/run/docker.sock > /tmp/dockerd.log 2>&1 &

DOCKERD_PID=$!
echo "(dind-entrypoint) Docker daemon started with PID $DOCKERD_PID"
wait $DOCKERD_PID
