#!/bin/sh
# This script is designed to be run from inside a Docker container. The script runs another Docker container. This
# is the "Docker in Docker" effect.

echo "Outer container hostname: $(hostname)"
echo ""

docker run --rm busybox:latest sh -c "
    echo ""
    echo 'Nested container hostname:' \$(hostname);
"
