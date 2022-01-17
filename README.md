# docker-playground

📚 Learning and exploring Docker <https://www.docker.com/>.

> Accelerate how you build, share and run modern applications
>
> -- <cite>https://www.docker.com</cite>

## Standalone sub-projects

This repository illustrates different concepts, patterns and examples via standalone sub-projects. Each sub-project is
completely independent of the others and do not depend on the root project. This _standalone sub-project constraint_
forces the sub-projects to be complete and maximizes the reader's chances of successfully running, understanding, and
re-using the code.

The sub-projects include:

### `basic/`

A basic "hello world" example of Docker that starts a container, executes a command inside of it, then stops it.

See the README in [basic/](basic/).

### `compose/`

A simple Docker Compose example.

See the README in [compose/](compose/).

### `dockerfile/`

An example project that builds a simple Docker image using a Dockerfile.

See the README in [dockerfile/](dockerfile/).

## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* DONE Add Docker Compose examples
* Add non-Docker examples. (I hardly know anything about non-Docker container technology)
* Add an example showing a "depends-on" relationship using a shell script instead of Docker Compose (because Docker Compose
  doesn't support the "depends_on" property since a long time). UPDATE: `depends_on` is supported still, it just doesn't
  do what you might think. It doesn't wait for an "is ready" check. Docker calls this fact out in the docs and describes
  [strategies for controlling start up order](https://docs.docker.com/compose/startup-order/). Spoiler alert: it's not
  slick, it requires custom shell scripting which of course may not be palatable if you wanted to used Docker images off-
  the-shelf without having to make changes.
* DONE Create a CI build in GitHub Actions
* DONE Add a Dockerfile example

