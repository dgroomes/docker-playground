# Extend from the BusyBox that we re-hosted in the local registry
FROM localhost:5000/my-busybox:latest

# Add the 'epoch.sh' script to the image and make sure it's somewhere on the path.
COPY epoch.sh /bin/epoch

# Make it executable
RUN chmod +x /bin/epoch
