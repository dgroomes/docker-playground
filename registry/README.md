# registry

NOT YET IMPLEMENTED

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
2. When finished, stop the registry
   * ```shell
     docker compose down
     ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] IN PROGRESS Scaffold the project
* [ ] Copy a Docker image from the public Docker Hub to the local registry. This is basically what the example in the
  [official docs](https://docs.docker.com/registry/deploying/) does. 
* [ ] Build a Docker image. Push it to the registry and pull it from the registry.
* [ ] Showcase the HTTP API. List images, get a manifest, etc.
* [ ] Illustrate the "base image" and "extending image" prototypical use case and make sure image layers are actually
  re-used. This is my main goal for this subproject.
