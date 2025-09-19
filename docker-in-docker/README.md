# docker-in-docker

Running Docker containers inside of Docker containers. Often referred to as DinD (Docker-in-Docker).


## Overview

We try to avoid too much inception in our software systems, but sometimes it's necessary. Docker-in-Docker is one of
those things. I need to better understand how it works, the moving parts, the security implications, the Linux-y
details, etc.

I want to use DinD to help me run "dev containers" for my own development work and especially with agentic coding tools.

In this project, I've created a minimal DinD base image, and wired together some scripting to show
a Docker container building and running another Docker container. For me, the interesting part is that the bind-mounting worked without hassle. Nice.

In principle, DinD is easy, but there is a lot of Linux and Docker trivia involved in cutting through the noise,
revealing the core principles, and getting it to work. I learned from these sources:

- https://github.com/docker-library/docker
- https://github.com/moby/moby/tree/master/hack
- https://github.com/devcontainers/features/tree/main/src/docker-in-docker

Keep in mind these processes that make up the example. It can get a little confusing:

1. The host process which runs the Docker engine (Linux or a Linux VM on macOS/Windows).
2. A container running inside the host. This also starts its own Docker engine process.
3. A container (a "nested" one) running inside the first container.


## Instructions

Follow these instructions to run the Docker-in-Docker example.

1. Pre-requisite: Docker
2. Say hello from the host
    - ```shell
      ./hello.sh
      ```
3. Build the Docker-in-Docker base image
    - ```shell
      docker build --tag my-docker-in-docker .
      ```
4. Run the DinD container and start a shell session 
    - ```shell
      docker run -it --privileged \
        --mount type=bind,source="$PWD",target=/app \
        my-docker-in-docker \
        bash
      ```
    - You are now in the "first-level" container. Notice we use the `--privileged` flag. This is required for the container to run its own Docker daemon.
5. Say hello from the first-level container
    - Inside the container, run the following command.
    - ```shell
      ./hello.sh
      ```
6. Start the Docker engine
    - While still inside the container, run the following command.
    - ```shell
      dockerd --host=unix:///var/run/docker.sock &
      ```
    - Wait a moment for the engine to initialize. You'll see startup messages from the daemon. When it's settled, you can verify that the daemon is running by running `docker version`. It should look something like the following.
    - ```text
      root@ceaee29a2c14:/app# docker version
      Client: Docker Engine - Community
       Version:           28.4.0
       ...
      
      Server: Docker Engine - Community
       Engine:
        Version:          28.4.0
      ```
7. Run a nested container and say hello from it 
    - While still inside the first-level container, run the following command.
    - ```shell
      docker run --rm \
        --mount type=bind,source=/app,target=/app \
        --workdir /app \
        debian:12-slim \
        ./hello.sh
      ```
    - This takes a moment to download the `debian:12-slim` image. Then it runs it. This is Docker-in-Docker in action!
8. Exit the first-level container
    - ```shell
      exit
      ```
9. Check the results
    - ```shell
      cat log.txt
      ```
    - You should see output like the following.
    - ```text
      Hello from my-MacBook.local
      Hello from 8cc254cd0c1c
      Hello from 2ce724f2419d
      ```
    - Each line represents execution at a different level: host, first-level container, and nested container. They each write to the same file through bind mounts.


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

- [x] DONE Hand-roll DinD scripts on Debian. I'm not interested in extending from Docker's DinD images for the same reason I'm not interested in extending from any image: it doesn't compose. I need my own reference. 
  - DONE First cut
  - DONE Prune down. I've pruned a lot. Now I want to vendor the .asc key or whatever so I don't need to curl the
    key (which is inherently like locking a door but the door isn't even fastened to the frame).
  - DONE more prune down
  - DONE Incorporate links to the related implementations (permalinks to the dind scripts in docker/moby/devcontainers)
- [ ] SKIP (I like the scope size as is) Add a Docker-out-of-Docker example. Consider making this it's own subproject, but maybe not.
- [ ] Where do the images go? Can I avoid the bandwidth and time cost of pulling images repeatedly? Should I use Docker-out-of-Docker?
- [ ] SKIP (I like the scope size as is) Show the networking user experience. For example, running a web server in a nested Docker container. I would have to have ahead-of-time exposed the right port on the first level container, right?
- [x] DONE Adapt the example to use bind mounts. This makes for a more compelling demo. 
- [ ] OBSOLETE (the interactive demo style doesn't have this problem) We're getting the class slow 10 second 'docker stop' on the first-level container. I'd rather not bring in tini
  because it's a dependency and not core to the demo. I might just unbundle the 'runs-on-host.sh' into just instructions
  and smaller scripts.
- [x] DONE (this task turned into reshaping into a more interactive demo) The DinD image is so slight now that it might as well be inlined into the first-level image for the sake of a smaller demo footprint.
