# docker-playground

📚 Learning and exploring Docker <https://www.docker.com/>.

> Accelerate how you build, share and run modern applications
>
> -- <cite>https://www.docker.com</cite>


## Standalone subprojects

This repository illustrates different concepts, patterns and examples via standalone subprojects. Each subproject is
completely independent of the others and do not depend on the root project. This _standalone subproject constraint_
forces the subprojects to be complete and maximizes the reader's chances of successfully running, understanding, and
re-using the code.

The subprojects include:

### `basic/`

A basic "hello world" example of Docker that starts a container, executes a command inside of it, then stops it.

See the README in [basic/](basic/).

### `compose/`

A simple Docker Compose example.

See the README in [compose/](compose/).

### `dockerfile/`

An example project that builds a simple Docker image using a Dockerfile.

See the README in [dockerfile/](dockerfile/).

### `introspective/`

A Docker image that introspects Docker metadata and networking information about its environment.

See the README in [introspective/](introspective/).


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [x] DONE Add Docker Compose examples
* [ ] Add non-Docker examples. (I hardly know anything about non-Docker container technology)
* [x] SKIP Add an example showing a "depends-on" relationship using a shell script instead of Docker Compose (because Docker Compose
  doesn't support the "depends_on" property since a long time). UPDATE: `depends_on` is supported still, it just doesn't
  do what you might think. It doesn't wait for an "is ready" check. Docker calls this fact out in the docs and describes
  [strategies for controlling start up order](https://docs.docker.com/compose/startup-order/). Spoiler alert: it's not
  slick, it requires custom shell scripting which of course may not be palatable if you wanted to used Docker images off-
  the-shelf without having to make changes.
* [x] DONE Create a CI build in GitHub Actions
* [x] DONE Add a Dockerfile example
* [ ] IN PROGRESS Consider doing a `registry` subproject. Docker supports this with an [open source registry](https://github.com/distribution/distribution),
  very cool. UPDATE: yes I definitely want to do this because the registry exposes an HTTP API that formally
  (and completely?) implements the access to content-addressable entities (layers, manifests, configs). This HTTP API
  should be legible, unlike the sometimes opaque and varied behavior of the `docker` CLI for commands like `inspect` (in
  my opinion). The registry is especially authoritative because it implements [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec).
  I'm not seeing the image layer get re-used as I expect in the `dockerfile` example. Maybe it's something to do with
  BuildKit and not using the cache, but I'm not sure. I want to actually illustrate layer re-use. I think if I use a local
  registry, maybe I can force this, or at least debug it. Interestingly though the file diff SHA digest is the same
  (good).


## Reference

* [Docker docs: *Glossary*](https://docs.docker.com/glossary/)
