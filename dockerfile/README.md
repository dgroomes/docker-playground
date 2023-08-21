# dockerfile

Building Docker images with `Dockerfile` files and making sense of the image content.


## Overview

The goal of this project is to gain some familiarity with building Docker images and to understand the makeup of a
Docker image: the layers, the metadata, etc. We explore these concepts by building build a Docker image that contains
the interpreter for the popular and expressive JSON-wrangling programming language named [`jq`](https://jqlang.github.io/jq/manual/).

This image can be considered a "base image" because it's a natural foundation to build other Docker images upon that
need `jq` installed. The project goes on to extend this image, and explore the resulting image layers and metadata using
familiar commandline tools like `tar`.


## Instructions

Follow these instructions to build a Docker image and run it as a container.

1. *Manually* download the `jq` interpreter:
   * Go to the [jq Download page](https://stedolan.github.io/jq/download/) and download the latest Linux 64-bit binary
   * Create a directory named `tmp/`
   * Move the binary you downloaded into `tmp/` and name the binary simply `jq` (it was likely downloaded with the name
    `jq-linux64`). It should look like this: `tmp/jq`.
2. Build the `docker-playground/jq` Docker image:
   * ```shell
     ./build-base-image.sh
     ```
   * Study the contents of that script to understand what it does.
3. Start a container using the image and pass it a `jq` expression:
    * ```shell
      echo '[1, 2, 3]' | docker run -i --rm docker-playground/jq '. | add'
      ```
    * The container will respond with the following text printed to the terminal.
      ```text
      6
      ```
4. Build the `docker-playground/jq-echo` Docker image:
   * ```shell
     DOCKER_BUILDKIT=1 docker build --file jq-echo.Dockerfile --tag docker-playground/jq-echo .
     ```
   * This new image builds upon the `docker-playground/jq` image. In this relationship, the `docker-playground/jq` image
     is considered the "base image".
5. Start a container using the image and pass it a JSON document with a special "message" field:
   * ```shell
     echo '{ "message": "hello" }' | docker run -i --rm docker-playground/jq-echo
     ```
   * You should see an echoing response from the container printed to the terminal.
     ```text
     "hello! hello!! hello!!!"
     ```
6. Now, let's inspect the base Docker image we built.
   * ```shell
     docker inspect docker-playground/jq
     ```
   * It will print low-level metadata about the image in JSON form.
   * ```json5
     [
       {
         "Id": "sha256:8e63f23d8a52505175726d4e234567652e02906334e64d9d8a12ea741bf03448",
         "RepoTags": [
           "docker-playground/jq:latest"
         ],
         // ... omitted ...
       }
     ]
     ```
   * This command is essential for tasks like debugging the effect of your `Dockerfile` on the built image.
7. Let's dig deeper and unpack the physical Docker image contents.
   * ```shell
     mkdir -p tmp/jq-extracted
     docker save --output tmp/jq.tar docker-playground/jq
     tar -C tmp/jq-extracted -xf tmp/jq.tar
     ```
   * The Docker image was exported as a tar, and then we extracted its contents. Browse the contents and explore. You'll
     notice that there is a directory for each of the Docker image layers. These are the file system diffs represented
     as tar files (`layer.tar`). Extract the contents of these layers and continue exploring. Try repeating this process
     for the `docker-playground/jq-echo` image too.


## Commentary

You might be thinking, "Wait, why do the instructions require downloading `jq` manually? Isn't it better to download `jq`
from the internet using an `ADD` Dockerfile command or a `RUN` command with `curl` or `wget`?" Answer: while that is a
common pattern, I generally don't prefer to use a Dockerfile for scripting. Instead, I like to copy items into the Docker
image with `COPY` commands instead of executing various commands to download and build the item from *within* the Docker
image with `ADD` and `RUN` commands. I might script out the downloading part in a script that I run on my computer, or
in a CI environment, but I really would rather not execute scripts in a Dockerfile. The ergonomics of scripting in a
Dockerfile is confusing in my opinion. See for example, this perplexing behavior of Bash in a Docker container:
<https://stackoverflow.com/questions/58573830/bash-instances-are-not-nesting-in-dockerfile-run>.  


## Notes

* Jump into a Bash shell session in a Debian container and explore:
  * ```shell
    docker run --rm -it debian:12 bash
    ```
* Jump into a container of the custom Docker image and explore:
  * ```shell
    docker run --rm -it --entrypoint bash jq-echo
    ```
* Inspect the custom image (useful for debugging when experimenting with the "ENTRYPOINT"):
  * ```shell
    docker inspect jq-echo
    ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Create a GitHub Actions CI workflow to build the image and run the example.
* [x] DONE (Well, the `docker` command can show you the config object, but I can't figure out how to make it show layer
  IDs. `docker image history` only shows `missing` and `docker manifest inspect` doesn't work for local images. So
  instead I exported the physical image data. Easy enough. UPDATE: actually this is not that great. The exported files
  also do not show the cryptographic layer ID even though I thought they did for a while. I got pretty turned around.
  Basically, if you don't see the `sha256:` prefix, then it's not a cryptographic ID but some other ID. I went and did
  the `registry` subproject and that's making the world make sense. The OCI registry API spec is nice.)
  Show the image layers and the steps/instructions (what are they called?)
* [x] DONE Create a "base image and extending image" example. This is prototypical stuff. This is one of the core value
  props of Docker. I'm particularly interested in what the JSON metadata files look like in the layers. I'm confused
  about what goes in the "config" object vs. what goes in the `json` metadata file in a layer.


## Reference

* [Docker official site: Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
* [jq docs](https://stedolan.github.io/jq/manual/)
