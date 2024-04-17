# Docker - Overview

## Docker - Installation  (using the apt repository)

```
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository.
Afterward, you can install and update Docker from the repository.
```

### Setup Apt repository

```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

### Add the repository to Apt sources

```
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
```

### Install the Docker packages

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Verify that the Docker Engine installation is successful by running the hello-world image

```
sudo docker run hello-world
```

## Docker Concepts

|             | Source Code | Template     | Instance         |
| ----------- | ----------- | ------------ | ---------------- |
| Docker      | Docker-File | Docker-Image | Docker-Container |

## Docker Commands

| Command         | Usage | Explanation |
| --------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| docker –version |                                                    | This command is used to get the currently installed version of docker.                                                        |
| docker pull     | docker pull <image name>                           | This command is used to pull images from the docker repository(hub.docker.com).                                               |
| docker run      | docker run -it -d <image name>                     | This command is used to create a container from an image.                                                                     |
| docker ps       |                                                    | This command is used to list the running containers.                                                                          |
| docker ps -a    |                                                    | This command is used to show all the running and exited containers.                                                           |
| docker exec     | docker exec -it <container id> bash                | This command is used to access the running container.                                                                         |
| docker stop     | docker stop <container id>                         | This command stops a running container.                                                                                       |
| docker kill     | docker kill <container id>                         | This command kills the container by stopping its execution immediately.                                                       |
| docker commit   | docker commit <conatainer id> <username/imagename> | This command creates a new image of an edited container on the local system.                                                  |
| docker login    |                                                    | This command is used to login to the docker hub repository.                                                                   |
| docker push     | docker push <username/image name>                  | This command is used to push an image to the docker hub repository.                                                           |
| docker images   |                                                    | This command lists all the locally stored docker images.                                                                      |
| docker rm       | docker rm <container id>                           | This command is used to delete a stopped container.                                                                           |
| docker rmi      | docker rmi <image-id>                              | This command is used to delete an image from local storage.                                                                   |
| docker build    | docker build <path to docker file>                 | This command is used to build an image from a specified docker file.                                                          |
| Docker copy     | COPY <source_file> <destination_directory>         | This command copies files/directories from the host system to the container system during docker image construction.          |
| Docker history  | docker history <image_name>                        | Using this command, you may examine the evolution of a Docker image or its constituent parts.                                 |
| Docker Logout   | docker logout [REGISTRY_URL]                       | This command is used to log out of a Docker registry or to delete the credentials used to login with it.                      |
| Docker network  | docker network create <network_name>               | Command tp manage Docker networks that enable containers to connect securely and isolatedly with another network resources.   |
| Docker restart  | docker restart [OPTIONS] CONTAINER [CONTAINER…]    | This command is used to restart one or more Docker containers that are currently operating.                                   |
| Docker search   | docker search [OPTIONS] TERM                       | This command searches for Docker images on Docker Hub, a public registry for Docker images.                                   |
| Docker volume   | docker volume create my_volume                     | This command creates a new Docker volume named “my_volume” in the Docker container.                                           |