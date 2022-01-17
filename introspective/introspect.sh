#!/usr/bin/env bash
# Introspect information about the environment. Are we running in a Docker container?

set -eu

# Are we Dockerized?
if [[ -f /.dockerenv ]]; then
  printf "Detected a .dockerenv file in the root of the file system. We are likely running in a Docker container.\n\n"
fi

# Get the IP address.
#
# There are so many different ways to do this and there is a lot I don't know. But at least when I run Debian in a
# Docker container, this always returns exactly one IP address.
#
# Related: https://askubuntu.com/a/1124395/888750
IP=$(hostname --ip-address)
printf "IP address:\n"
printf "\t%s" $IP
printf "\n\n"

CONTAINER_NAME=$(dig -x "$IP" +short | cut -d'.' -f1)
printf "The Docker container name (found via dig):\n"
printf "\t%s" $CONTAINER_NAME
printf "\n\n"
