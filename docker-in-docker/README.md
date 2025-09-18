# docker-in-docker

Running Docker containers inside of Docker containers. Often referred to as DinD (Docker-in-Docker).


## Overview

We try to avoid too much inception in our software systems, but sometimes it's necessary. Docker-in-Docker is one of
those things. I need to better understand how it works, the moving parts, the security implications, the Linux-y
details, etc.

I want to use DinD to help me run "dev containers" for my own development work and especially with agentic coding tools.
In this project, I've configured a basic DinD base image, and wired together some other scripts and Dockerfiles to show
a Docker container building and running another Docker container.

In principle, this is easy, but there is a lot of Linux and Docker trivia involved in cutting through the noise,
revealing the core principles, and getting it to work. I learned from these sources:

- https://github.com/docker-library/docker
- https://github.com/moby/moby/tree/master/hack
- https://github.com/devcontainers/features/tree/main/src/docker-in-docker

Keep in mind these processes that make up the example. It can get a little confusing:

1. The host process which runs the Docker engine (Linux or a Linux VM on macOS/Windows).
2. A container running inside the host. This also starts its own Docker engine process.
3. A nested container running inside the first container.


## Instructions

Follow these instructions to run a Docker-in-Docker example.

1. Pre-requisite: Docker
2. Build the custom DinD base image
    - ```shell
      docker build --file Dockerfile.dind --tag docker-playground/docker-in-docker-dind:local .
      ```
3. Kick off the rest of the demo by running the host script
    - ```shell
      ./runs-on-host.sh
      ```
    - You should see output like the following.
    - ```text
      (host) Building the first-level Docker image...
      sha256:...
      (host) Running the first-level Docker container...
      ...
      (host) Running the script inside the first-level Docker container...
      (first-level-container) Waiting for Docker daemon to be ready...
      (first-level-container) Docker daemon is ready!
      (first-level-container) Building the nested container image ...
      sha256:...
      (first-level-container) Running the nested container ...
      (host) Stopping the first-level Docker container...
      ...
      (host) Complete! Check the log.txt file to see what happened.
      ```
4. Check the `log.txt` to see the evidence of different containers
    - ```shell
      cat log.txt
      ```
    - It should look something like the following.
    - ```text
      (host) Hello from my-MacBook.local
      (first-level-container) Hello from ee9374dd575e
      (nested-container) Hello from 230aec7e51cb
      ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

- [x] DONE Hand-roll DinD scripts on Debian. I'm not interested in extending from Docker's DinD images for the same reason I'm not interested in extending from any image: it doesn't compose. I need my own reference. 
  - DONE First cut
  - DONE Prune down. I've pruned a lot. Now I want to vendor the .asc key or whatever so I don't need to curl the
    key (which is inherently like locking a door but the door isn't even fastened to the frame).
  - DONE more prune down
  - DONE Incorporate links to the related implementations (permalinks to the dind scripts in docker/moby/devcontainers)
- [ ] Add a Docker-out-of-Docker example. Consider making this it's own subproject, but maybe not.
- [ ] Where do the images go? Can I avoid the bandwidth and time cost of pulling images repeatedly? Should I use Docker-out-of-Docker?
- [ ] Show the networking user experience. For example, running a web server in a nested Docker container. I would have to have ahead-of-time exposed the right port on the first level container, right?
- [x] DONE Adapt the example to use bind mounts. This makes for a more compelling demo. 
- [ ] We're getting the class slow 10 second 'docker stop' on the first-level container. I'd rather not bring in tini
  because it's a dependency and not core to the demo. I might just unbundle the 'runs-on-host.sh' into just instructions
  and smaller scripts.
- [ ] The DinD image is so slight now that it might as well be inlined into the first-level image for the sake of a smaller demo footprint.
