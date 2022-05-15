# Docker file repo

## Description
this repo is the docker file for building Hero 2022 RoboMaster Competition codes runtime env.

## How to use

to build this docker image in your computer, follow these constructions below:

however, there has already existed **a fantastic tutorial in Chinese**!
there is the link: https://yeasy.gitbook.io/docker_practice/, which contains 
not only how to install but also how to use docker.

### install docker on your computer

if you did not install docker on your computer before(using `docker --version`
to test), then you should install docker engine first.

install docker engine and other depends throw shell cmds:
```shell
# $ curl -fsSL test.docker.com -o get-docker.sh
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# sudo sh get-docker.sh --mirror Aliyun  # with mirror server
```

start docker server:
```shell
sudo systemctl enable docker
sudo systemctl start docker
```

add current user into docker usergroup 
(to avoid using docker with `sudo`):
```shell
sudo groupadd docker
sudo usermod -aG docker $USER
```

you should better restart your computer after this step.(or logout) 

then check whether you had install docker:
```shell
docker run --rm hello-world
```

if it shows as below, congratulations! your docker has installed successfully.
```shell
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete
Digest: sha256:308866a43596e83578c7dfa15e27a73011bdd402185a84c5cd7f32a88b501a24
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

**for further informations, please refer to docker [doc page](https://docs.docker.com/engine/install/)**


## build

before start build, please make sure you have some software to help
you get rid of GFW. I using clash, so it has clash proxy settings inside
[127.0.0.1:7890], which means **only with clash proxy it can works fine**.

running this command in your shell:
```shell
docker build --network host -f Dockerfile_<platform> -t <image name> https://github.com/paras-zomby/build_dockerfile_hero2022
```
then your build job will start. the platform can be *x86* or *arm64v8*
, and image name can be what erver you want.

## use docker image in dockerhub
there are also built docker images in dock hub from those dockfile. 
I have publish it, but it can't be guaranteed to be the newest.

you can use it through:
```shell
docker pull zig175/hero2022_x86
docker pull zig175/hero2022_armv8
```

## Using image through scripts

### Create container

```shell
bash $PROJECT/scripts/create_docker_container.sh \
      -p [x86/arm] [-n <container_name>]
```

using `create_docker_container.sh` to create a container.
- `-p` choose the platform. It can be 'x86' or 'arm'.
- `-n` [Optional] decide the container name, default is 'hero'.
