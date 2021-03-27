# Extend the Debian Docker image. See https://hub.docker.com/_/debian
FROM debian:10

# Copy over the jq binary
COPY tmp/jq /usr/local/bin

# Copy over our own custom jq functions
RUN mkdir /opt/docker-playground
COPY echo.jq /opt/docker-playground

# Define an entrypoint and command. This is the default thing that will run when a container is started using this image.
# They can be overridden via command line arguments.
ENTRYPOINT ["jq", "--null-input", "-L", "/opt/docker-playground"]
CMD ["include \"echo\"; {message: \"hi\"} | .message | echo"]
