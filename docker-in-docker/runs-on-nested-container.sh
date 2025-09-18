#!/bin/sh
# This is designed to run in the nested container.

echo "(nested-container) Hello from $(hostname)" >> /app/log.txt
