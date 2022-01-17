# compose

A simple Docker Compose example.

## Instructions

Start a Docker container by running this command:

```shell
docker-compose up
```

You should see something like:

```
$ docker-compose up
[+] Running 2/2
 ⠿ Network compose_default         Created                                                                                                                                                             0.2s
 ⠿ Container compose-my-busybox-1  Created                                                                                                                                                             0.5s
Attaching to compose-my-busybox-1
compose-my-busybox-1  | hello world!
compose-my-busybox-1 exited with code 0
```

## Reference

* [BusyBox: The Swiss Army Knife of Embedded Linux](https://hub.docker.com/_/busybox)
* [Docker official docs: *Overview of Docker Compose*](https://docs.docker.com/compose/)
* [Docker official docs: docker-compose.yml file reference](https://docs.docker.com/compose/compose-file/)
