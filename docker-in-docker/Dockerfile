# A Debian-based image with the Docker engine and CLI pre-installed.
#
# This is a minimal starting point for Docker-in-Docker (DinD).

FROM debian:12-slim

RUN apt-get update && apt-get install -y ca-certificates

# The GPG key for Docker's APT repository is version controlled in this codebase.
# When Docker eventually makes a new key, download it with something like:
#
#     curl -fsSL https://download.docker.com/linux/debian/gpg --output docker.asc
#
COPY docker.asc /etc/apt/keyrings/docker.asc
COPY docker.list /etc/apt/sources.list.d/docker.list

# Install Docker Engine and CLI
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli

WORKDIR /app
