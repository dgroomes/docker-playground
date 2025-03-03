# https://hub.docker.com/_/debian
FROM debian:12

RUN apt-get update && apt-get install -y curl
