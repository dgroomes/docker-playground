# docker-playground

📚 Learning and exploring Docker <https://www.docker.com/>.

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

## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* DONE Add Docker Compose examples
* Add non-Docker examples. (I hardly know anything about non-Docker container technology)
* Add an example showing a "depends-on" relationship using a shell script instead of Docker Compose (because Docker Compose
  doesn't support the "depends_on" property since a long time)  
* Create a CI build in GitHub Actions

