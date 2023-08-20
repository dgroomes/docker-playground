# Extend the Debian Docker image. See https://hub.docker.com/_/debian
FROM debian:12

# Copy over the jq binary
COPY tmp/jq /usr/local/bin

# Define an entrypoint. This is the default thing that will run when a container is started using this image.
# This can be overridden via a command line argument.
ENTRYPOINT ["jq", "-L", "/opt/docker-playground"]
