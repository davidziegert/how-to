# Docker

## Installation (using the apt repository)

```
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository.
Afterward, you can install and update Docker from the repository.
```

### Setup Apt repository

```bash
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

### Add the repository to Apt sources

```bash
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
```

### Install the Docker packages

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Verify that the Docker Engine installation is successful by running the hello-world image

```bash
sudo docker run hello-world
```

## Docker Concepts

|        | Source Code | Template     | Instance         |
| ------ | ----------- | ------------ | ---------------- |
| Docker | Docker-File | Docker-Image | Docker-Container |

## Docker Commands

| Command         | Usage                                              | Explanation                                                                                                                 |
| --------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| docker -version |                                                    | This command is used to get the currently installed version of docker.                                                      |
| docker pull     | docker pull <image name>                           | This command is used to pull images from the docker repository(hub.docker.com).                                             |
| docker run      | docker run -it -d <image name>                     | This command is used to create a container from an image.                                                                   |
| docker ps       |                                                    | This command is used to list the running containers.                                                                        |
| docker ps -a    |                                                    | This command is used to show all the running and exited containers.                                                         |
| docker exec     | docker exec -it <container id> bash                | This command is used to access the running container.                                                                       |
| docker stop     | docker stop <container id>                         | This command stops a running container.                                                                                     |
| docker kill     | docker kill <container id>                         | This command kills the container by stopping its execution immediately.                                                     |
| docker commit   | docker commit <conatainer id> <username/imagename> | This command creates a new image of an edited container on the local system.                                                |
| docker login    |                                                    | This command is used to login to the docker hub repository.                                                                 |
| docker push     | docker push <username/image name>                  | This command is used to push an image to the docker hub repository.                                                         |
| docker images   |                                                    | This command lists all the locally stored docker images.                                                                    |
| docker rm       | docker rm <container id>                           | This command is used to delete a stopped container.                                                                         |
| docker rmi      | docker rmi <image-id>                              | This command is used to delete an image from local storage.                                                                 |
| docker build    | docker build <path to docker file>                 | This command is used to build an image from a specified docker file.                                                        |
| Docker copy     | COPY <source_file> <destination_directory>         | This command copies files/directories from the host system to the container system during docker image construction.        |
| Docker history  | docker history <image_name>                        | Using this command, you may examine the evolution of a Docker image or its constituent parts.                               |
| Docker Logout   | docker logout [REGISTRY_URL]                       | This command is used to log out of a Docker registry or to delete the credentials used to login with it.                    |
| Docker network  | docker network create <network_name>               | Command tp manage Docker networks that enable containers to connect securely and isolatedly with another network resources. |
| Docker restart  | docker restart [OPTIONS] CONTAINER [CONTAINER…]    | This command is used to restart one or more Docker containers that are currently operating.                                 |
| Docker search   | docker search [OPTIONS] TERM                       | This command searches for Docker images on Docker Hub, a public registry for Docker images.                                 |
| Docker volume   | docker volume create my_volume                     | This command creates a new Docker volume named “my_volume” in the Docker container.                                         |

## Configuration

### Manage Docker as a non-root user

```
The Docker daemon binds to a Unix socket, not a TCP port. By default it's the root user that owns the Unix socket, and other users can only access it using sudo. The Docker daemon always runs as the root user.

If you don't want to preface the docker command with sudo, create a Unix group called docker and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group. On some Linux distributions, the system automatically creates this group when installing Docker Engine using a package manager. In that case, there is no need for you to manually create the group.

Create the docker group and add your user to the docker group.
```

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
sudo service docker restart
```

### Configure Docker to start on boot with systemd

```
Many modern Linux distributions use systemd to manage which services start when the system boots. On Debian and Ubuntu, the Docker service starts on boot by default. To automatically start Docker and containerd on boot for other Linux distributions using systemd, run the following commands:
```

```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```
