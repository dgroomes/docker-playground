# https://hub.docker.com/_/debian
FROM debian:12

RUN apt-get update && apt-get install -y squid

COPY squid.conf /etc/squid/squid.conf

# Set default command to run Squid in foreground mode
CMD ["squid", "-N", "-d1"]
