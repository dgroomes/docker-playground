# basic

A basic "hello world" example of Docker that starts a container, executes a command inside of it, then stops it.


## Instructions

Follow these instructions to create a container and interact with it.

1. Create a Docker container
   * ```shell
     ./start.sh
     ```
2. Execute a command from inside the container
   * ```shell
     ./say-hello.sh
     ```
3. Stop the container
   * ```shell
     ./stop.sh
     ```


## Reference

* [BusyBox: The Swiss Army Knife of Embedded Linux](https://hub.docker.com/_/busybox)
* [`docker run` reference](https://docs.docker.com/engine/reference/commandline/run/)  
* [`docker exec` reference](https://docs.docker.com/engine/reference/commandline/exec/)
