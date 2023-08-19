# Extend the Debian Docker image. See https://hub.docker.com/_/debian
FROM debian:12

# Install the 'dnsutils' package which contains the 'dig' command
RUN apt-get update && apt-get install -y dnsutils

# Copy over the introspection script
COPY introspect.sh /
