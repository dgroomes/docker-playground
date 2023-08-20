# This Dockerfile extends from the base image we created earlier and creates a new image with a custom jq function.
#
# Notice how the Dockerfile file is named 'jq-echo.Dockerfile'. When you need multiple Dockerfiles in the same project,
# a useful convention is to give them unique name prefixes. IDEs should be able to provide syntax highlighting because
# the '.Dockerfile' file extension is recognizable.

FROM docker-playground/jq

# Copy over our own custom jq functions
RUN mkdir /opt/docker-playground
COPY echo.jq /opt/docker-playground

# Set the default command to a jq expression which assumes that a JSON payload containing a 'message' field is piped
# from stdin. The jq expression extracts the 'message' field and passes it to the 'echo' jq function.
CMD ["include \"echo\"; .message | echo"]
