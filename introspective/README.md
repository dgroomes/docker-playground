# introspective

A Docker image that introspects Docker metadata and networking information about its environment.

## Instructions

Follow these instructions to build the introspecting Docker image and run it as multiple containers.

1. Build the image and start containers:
   * `docker-compose up --build --detach`
2. Attach to one of the containers:
   * `docker attach introspective-introspecting-container-a-1`
3. While in the container, execute the introspection script
   * `/introspect.sh`
   * You should see something like:
     ```text
     Detected a .dockerenv file in the root of the file system. We are likely running in a Docker container.

     IP address:
         172.24.0.3

     The Docker container name (found via dig):
         introspective-introspecting-container-a-1
     ```
4. Detach
   * Press `Ctrl + P` then `Ctrl + Q`
5. Try the same thing in the other container!
   * `docker attach introspective-introspecting-container-b-1`
   * Repeat the earlier steps.
   * Notice that the IP address and container names are different! For me, the IP address was `172.24.0.2`.
6. Stop the containers:
   * `docker-compose down`

## Description

Container technology, like Docker and containerd, create isolated runtimes for the container processes where the process
is blissfully unaware of other processes and files on the host computer. But, the runtime does leave some traces of
itself. For example with Docker, a Docker container is given a special [`.dockerenv` file in the root of its filesystem](https://superuser.com/a/1115029).
In this way, a process can *introspect* its environment and infer that it is likely running in a Docker container if it
finds the `/.dockerenv` file.

There are similar fingerprints and clues too. The `introspective` sub-project aims to explore some of these.

## Notes

I decided to create multiple containers because I'm interested in the ability of a Docker container to discover other
containers in the network, but I've struggled to figure out how to do that without resorting to giving explicit
hints in the configuration (`docker-compose.yml`) or hardcoding service names in the script.

## Reference

* [StackOverflow answer for "How can I get docker's container name from inside the container?"](https://stackoverflow.com/a/64790547/)
  * Reverse DNS lookup trick for finding the container's name. Does this only work for Docker Compose?
* [Docker docs: "Container networking"](https://docs.docker.com/config/containers/container-networking)
