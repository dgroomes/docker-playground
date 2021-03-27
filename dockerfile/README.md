# dockerfile

An example project that builds a simple Docker image using a Dockerfile.

## Instructions

1. *Manually* download the `jq` program:
   1. Go to the [jq Download page](https://stedolan.github.io/jq/download/) and download the latest Linux 64-bit binary
   1. Create a directory named `tmp/`
   1. Move the binary you downloaded into `tmp/` and name the binary simply `jq` (it was likely downloaded with the name
    `jq-linux64`). It should look like this: `tmp/jq`.
1. Build the Docker image:
  * `./build.sh`
1. Start a container using the image and pass it a JSON document with a special "message" field:
  * 
  ```
  echo '{ "message": "hello" }' | docker run -i --rm jq-echo
  ```
  * You should see a response from the container printed to the terminal! It should say:
  ```
  hello! hello!! hello!!!
  ```


## Commentary

You might be thinking, "Wait, why do the instructions require downloading `jq` manually? Isn't it better to download `jq`
from the internet using an `ADD` Dockerfile command or a `RUN` command with `curl` or `wget`?" Answer: while that is a
common pattern, I generally don't prefer to use a Dockerfile for scripting. Instead, I like to copy items into the Docker
image with `COPY` commands instead of executing various commands to download and build the item from *within* the Docker
image with `ADD` and `RUN` commands.

## Notes

* Jump into a Bash shell session in a Debian container and explore:
  * `docker run --rm -it debian:10 bash` to
* Jump into a container of the custom Docker image and explore:
  * `docker run --rm -it --entrypoint bash jq-echo`
* Inspect the custom image (useful for debugging when experimenting with the "ENTRYPOINT"):
  * `docker inspect jq-echo`

## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* Create a GitHub Actions CI workflow to build the image and run the example  

## Referenced materials

* [Docker official site: Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
* [jq docs](https://stedolan.github.io/jq/manual/)