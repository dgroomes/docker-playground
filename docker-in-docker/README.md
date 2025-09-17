# docker-in-docker

Running Docker containers inside of Docker containers. Often referred to as DinD (Docker-in-Docker).


## Overview

We try to avoid inception in our software systems, but sometimes it's necessary. Docker-in-Docker is one of those things. I need to better understand how it works, the moving parts, the security implications, the Linux-y details, etc.

I want to use DinD to help me run "dev containers" for my own development work and especially with agentic coding tools. So far, I've had some success with using Docker's own packaging of a DinD image. See, for example, the [`dockerd-entrypoint.sh`](https://github.com/docker-library/docker/blob/9ec9a719b2f803cb351c0db954f5653a4fd1d38c/dockerd-entrypoint.sh) script in the <https://github.com/docker-library/docker> GitHub repository. I don't fully understand how all these components tie together. There is also some DinD stuff in <https://github.com/moby/moby/tree/master/hack>. I also don't fully understand the lineage of Moby vs Docker, but this is the area.

This project shows a simple DinD example that builds and runs a Docker container that itself builds and runs a Docker
container. Keep in mind these processes that make up the example. It can get a little confusing:

1. The host process which runs the Docker engine (Linux or a Linux VM on macOS/Windows).
2. A container running inside the host. This also starts its own Docker engine process.
3. A nested container running inside the first container.


## Instructions

Follow these instructions to run a Docker-in-Docker example.

1. Pre-requisite: Docker
2. Kick off the demo by running the host script
    - ```shell
      ./runs-on-host.sh
      ```
    - You should see output like the following.
    - ```text
      ... omitted ...
       => [1/3] FROM docker.io/library/docker:28-dind@sha256:831644212c5bdd0b3362b5855c87b980ea39a83c9e9adc  0.0s
      ... omitted ...
       => CACHED [2/3] WORKDIR /app                                                                          0.0s
      ... omitted ...
       => [3/3] COPY runs-on-first-level-container.sh .                                                      0.0s
      ... omitted ...
       => exporting to image                                                                                 0.1s
      ... omitted ... 
      Waiting for Docker daemon to be ready...
      Attempt 1/30...
      Docker daemon is ready!
      ... omitted ... 
      #5 [1/3] FROM docker.io/library/debian:12@sha256:7dc1e2b39b0147079a16347915e9583cb2f239d4896fe2beac396b979e5c06a9                                                                                                       
      ... omitted ... 
      #7 [3/3] COPY runs-on-nested-container.sh .
      #7 DONE 0.0s
      ... omitted ... 
      first-level-container
      Complete! Check the log.txt file to see what happened.
      ```
3. Check the `log.txt` to see the evidence of different containers
    - ```shell
      cat log.txt
      ```
    - It should look something like the following.
    - ```text
      Hello from my-MacBook-Pro.local    # Host
      Hello from 7c457ed43cbf                # First-level container  
      Hello from f2cf312322f8                # Nested container
      ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

- [ ] Hand-roll DinD scripts on Debian. I'm not interested in extending from Docker's DinD images for the same reason  I'm not interested in extending from any image: it doesn't compose. I need my own reference. 
- [ ] Add a Docker-out-of-Docker example. Consider making this it's own subproject, but maybe not.
- [ ] Where do the images go? Can I avoid the bandwidth and time cost of pulling images repeatedly? Should I use Docker-out-of-Docker?
- [ ] Show the networking user experience. For example, running a web server in a nested Docker container. I would have to have ahead-of-time exposed the right port on the first level container, right?
- [x] DONE Adapt the example to use bind mounts. This makes for a more compelling demo. 
