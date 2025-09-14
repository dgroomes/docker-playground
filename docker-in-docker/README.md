# docker-in-docker

Running Docker containers inside of Docker containers. Also known as Docker-in-Docker (DinD).


## Overview

We try to avoid inception in our software systems, but sometimes it's necessary. Docker-in-Docker is one of those things. I need to better understand how it works, the moving parts, the security implications, the Linux-y details, etc.

I want to use DinD to help me run "dev containers" for my own development work and especially with agentic coding tools. So far, I've had some success with using Docker's own packaging of a DinD image. See, for example, the the [`dockerd-entrypoint.sh`](https://github.com/docker-library/docker/blob/9ec9a719b2f803cb351c0db954f5653a4fd1d38c/dockerd-entrypoint.sh) script in the <https://github.com/docker-library/docker> GitHub repository. I don't fully understand how all these components tie together. There is also some DinD stuff in <https://github.com/moby/moby/tree/master/hack>. I also don't fully understand the lineage of Moby vs Docker, but this is the area.

This project shows a simple DinD example. I want to build it out with more examples.


## Instructions

Follow these instructions to build and run the Docker-in-Docker demonstration.

1. Build the demo image
   - ```shell
     docker build --tag docker-playground/dind .
     ```
   - This builds our custom `docker-playground/dind` image by extending the official `docker:28-dind` image 
     and adding our demonstration script.
2. Start a container
   - ```shell
     docker run --privileged --detach --name my-dind --rm docker-playground/dind
     ```
   - This starts the container in the background with the Docker daemon running inside it.
3. Run the demonstration
   - ```shell
     docker exec my-dind dind-demo.sh
     ```
   - You should see something like the following.
   - ```text
     Outer container hostname: 58d947a38155
     
     Unable to find image 'busybox:latest' locally
     latest: Pulling from library/busybox
     ... omitted ...
     
     Nested container hostname: cc2f3b997b54
     ```
   - We connected to a container (the outer one), which ran another container (the nested one) inside of it. This is the Docker-in-Docker concept in action.
4. (Optional) Explore the container interactively:
   - ```shell
     docker exec -it my-dind sh
     ```
   - This gives you a shell inside the DinD container where you can run Docker commands manually.
   - Try commands like `docker version`, `docker ps`, `docker run --rm busybox echo "Hello from nested container!"`
5. Stop and remove the container:
   - ```shell
     docker stop my-dind
     ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

- [ ] Hand-roll DinD scripts on Debian. I'm not interested in extending from Docker's DinD images for the same reason  I'm not interested in extending from any image: it doesn't compose. I need my own reference. 
- [ ] Add a Docker-out-of-Docker example. Consider making this it's own subproject, but maybe not.
- [ ] Where do the images go? Can I avoid the bandwidth and time cost of pulling images repeatedly? Should I use Docker-out-of-Docker?
- [ ] Show the networking user experience. For example, running a web server in a nested Docker container. I would have to have ahead-of-time exposed the right port on the first level container, right?
