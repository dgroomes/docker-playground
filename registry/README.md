# registry

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
4. Use the HTTP API to inspect all the components that are now in the registry.
   * List all repositories with the following `curl` command.
   * ```shell
     curl -X GET http://localhost:5000/v2/_catalog
     ```
   * Drill into the `my-busybox` repository to list its tags.
   * ```shell
     curl -X GET http://localhost:5000/v2/my-busybox/tags/list
     ```
   * Get the manifest for the `my-busybox:latest` tag. Take care to request the v2 manifest schema.
   * ```shell
     curl -X GET http://localhost:5000/v2/my-busybox/manifests/latest -H "Accept: application/vnd.docker.distribution.manifest.v2+json"
     ```
   * Finally, let's look at the "configuration" object for the `my-busybox:latest` image. We have to very precise here
     because images are not identified by their tags but by their digests. In our case, there is exactly one image for
     the `my-busybox:latest` tag (there might be more if we created multiple `my-busybox:latest` images for different
     architectures). You have to take the digest of the configuration object we found in the earlier manifest request.
     With this value we can get the configuration object from the "blobs" endpoint.
   * ```shell
     curl -X GET http://localhost:5000/v2/my-busybox/blobs/sha256:fc9db2894f4e4b8c296b8c9dab7e18a6e78de700d21bc0cfaf5c78484226db9c
     ```
   * Next, let's explore how image layers are re-used in the ecosystem by extending from the `my-busybox:latest` image. 
5. Build and push the custom Docker image
   * ```shell
     docker build -t localhost:5000/my-busybox-extended .
     docker push localhost:5000/my-busybox-extended
     ```
6. Inspect the image layers
   * Follow the same HTTP API requests that we made earlier. The `my-busybox-extended` image should use the same layers
     as the `my-busybox` image except for the last layer which is where we added the `epoch.sh` script.
7. When finished, stop the registry
   * ```shell
     docker compose down
     ```



## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE Scaffold the project
* [x] DONE Copy a Docker image from the public Docker Hub to the local registry. This is basically what the example in the
  [official docs](https://docs.docker.com/registry/deploying/) does. 
* [x] DONE Build a Docker image. Push it to the registry and pull it from the registry.
* [x] DONE Showcase the HTTP API. List images, get a manifest, etc.
* [x] OBSOLETE (I'm using the busybox image as a base image. It has the same effect) Illustrate the "base image" and "extending image" prototypical use case and make sure image layers are actually
  re-used. This is my main goal for this subproject.
* [x] DONE What kind of database is the registry using? Can we connect to it and query it?
   * It looks like it just writes to files. Let's connect and explore.
   * ```shell
     docker exec -it registry-registry-1 sh
     ```
   * ```shell
     docker exec registry-registry-1 ls /var/lib/registry/docker/registry/v2/repositories
     docker exec registry-registry-1 ls /var/lib/registry/docker/registry/v2/blobs/sha256
     ```
* [ ] Explore what changes when you use BuildKit. I'm suspicious about the layers. I think they get squashed (a good thing mostly).


## Reference

* [Docker docs: *Docker Registry HTTP API V2*](https://docs.docker.com/registry/spec/api/)
