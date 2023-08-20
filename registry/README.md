# registry

NOT YET FULLY IMPLEMENTED

This subproject illustrates how to run and use a local Docker registry.


## Overview

The Docker HTTP API is pretty neat and its really amazing that Docker provides an open source implementation of the
[OCI Distribution Specification](https://github.com/opencontainers/distribution-spec) in their [`distribution`](https://github.com/distribution/distribution)
project. This project runs a local instance of a registry and explores it with tutorial-style examples.


## Instructions

Follow these instructions to host and interact a local Docker registry.

1. Run a local Docker registry
   * ```shell
     docker compose up
     ```
   * Do not use the `--detach` option because we want to see the HTTP access logs. While they are a little hard to make
     sense of at first glance, they tell a lot about what is going on when you push and pull Docker images.
2. Pull the latest `busybox` image from Docker Hub and re-host it in the local registry
   * ```shell
     docker pull busybox
     docker tag busybox localhost:5000/my-busybox
     docker push localhost:5000/my-busybox
     ```
   * Note: the `localhost:5000` prefix is a way to tell `docker` CLI that the image should be pushed to the local registry. 
3. Clear the local cache and pull the image from the local registry
   * ```shell
     docker image remove busybox
     docker image remove localhost:5000/my-busybox
     docker pull localhost:5000/my-busybox
     ```
4. When finished, stop the registry
   * ```shell
     docker compose down
     ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE Scaffold the project
* [x] DONE Copy a Docker image from the public Docker Hub to the local registry. This is basically what the example in the
  [official docs](https://docs.docker.com/registry/deploying/) does. 
* [ ] Build a Docker image. Push it to the registry and pull it from the registry.
* [ ] Showcase the HTTP API. List images, get a manifest, etc.
* [ ] Illustrate the "base image" and "extending image" prototypical use case and make sure image layers are actually
  re-used. This is my main goal for this subproject.
* [ ] What kind of database is the registry using? Can we connect to it and query it?
