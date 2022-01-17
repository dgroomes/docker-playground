#!/usr/bin/env bash
# Create and start a Docker container from the BusyBox Docker image
#
# Options explained:
#
#   "--interactive" and "--tty" are usually used together if they are used at all. They create a terminal session which
#   you can use. In other words, you get a command-line experience inside the Docker container
#
#   "--rm" Remove. The container will be removed when it is stopped. In some cases, you want a container to stick
#   around after it is stopped because you might come back to it later. It's more common however to use containers
#   briefly to work on something and then throw them away completely when you're done. In fact, the quick start nature
#   and ephemeral quality of containers is a main appeal of containers!
#
#   "--name". The contain will be given this name. Often this is not needed, but in our case if we give it a specific
#   name, like "my-busybox", then we know how to identify this container later on in our "say-hello.sh" and "stop.sh"
#   scripts. If a name is not given, then a random name will be used. So that's not helpful for scripting purposes.
#
#   "--detach". We don't actually want to enter into a command-line experience in the container, so we detach from it.
#   The container will continue to run. You can later attach to the container with "docker attach my-busybox" but be
#   careful when you want to detach again. It's necessary to use a special key combination to exit (or, "detach")
#   without stopping the container. Press "Ctrl + P" then "Ctrl + Q". See https://stackoverflow.com/a/25354585.
#   If you exit the container's terminal session with "exit" or "Ctrl + D", the container will stop.


docker run --interactive --tty --rm --name my-busybox --detach busybox
