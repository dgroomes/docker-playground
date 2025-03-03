# networking

Exploring container networking with a proxy example.


## Overview

Container technology isolates processes in multiple ways, and networking is one of them. Let's explore Docker's
networking features and specifically how we can isolate a container's networking environment. We'll use a familiar use
case: proxy servers.

The example creates two containers:

* A **sequestered** container
    * This is isolated from external networks, but is able to communicate with the proxy container.
* A **proxy** container
    * This has full network access.
    * It uses Squid as a forward proxy to provide the sequestered container with limited access to external hosts.


## Instructions

Follow these steps to run the example.

1. Start the containers and networks:
    * ```shell
      docker compose up --detach
      ```
2. Attach to the sequestered container:
    * ```shell
      docker attach networking-sequestered-1
      ```
3. In the sequestered container, test connectivity to the internet
    * ```shell
      curl https://www.w3.org
      ```
    * It should fail with the following message.
    * ```text
      curl: (6) Could not resolve host: www.w3.org
      ```
4. In the sequestered container, test connectivity by way of the proxy
    * ```shell
      curl --proxy http://proxy:3128 https://www.w3.org
      ```
    * It should succeed and print the HTML for that page. Next, try connecting to a site that is not allowed.
    * ```shell
      curl --proxy http://proxy:3128 https://mozilla.org
      ```
    * It should fail with the following message.
    * ```text
      curl: (56) CONNECT tunnel failed, response 403
      ```
5. Detach
    * Press `Ctrl + P` then `Ctrl + Q`
6. Stop and remove the containers and networks:
    * ```shell
      docker compose down
      ```
