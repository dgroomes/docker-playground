#!/bin/sh
# This is designed to run in the nested container.

echo "Hello from $(hostname)" >> /app/log.txt
