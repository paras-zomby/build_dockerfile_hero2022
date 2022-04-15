FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy "http://127.0.0.1:7890"
ENV HTTP_PROXY "http://127.0.0.1:7890"
ENV https_proxy "http://127.0.0.1:7890" 
ENV HTTPS_PROXY "http://127.0.0.1:7890"
ENV all_proxy "socks5://127.0.0.1:7890"

RUN apt-get -y update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get -y update && apt-get upgrade -y && apt-get install -y \ 
    pkg-config \
    g++-11 gcc-11 \
    vim \
    git \
    cmake \ 
    make  \ 
    wget unzip\ 
    libgtk2.0-dev \ 
    libgtk-3-dev \ 
    libavcodec-dev \ 
    libavformat-dev \ 
    libjpeg-dev \
    libswscale-dev \
    libtiff5-dev  \
    curl gdb  \
    rsync \
    ccache htop\
    ssh \
    libgoogle-glog-dev libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libcanberra-gtk-module python3 python3-dev python3-numpy python3-pip libssl-dev libpng-dev libwebp-dev libavresample-dev libavutil-dev libopenexr-dev

# opencv4.5.3安装配置
RUN mkdir opencv \
    && cd /opencv \
    && wget -t 0 https://github.com/opencv/opencv/archive/4.5.3.zip \
    && unzip 4.5.3.zip && rm 4.5.3.zip \
    && wget -t 0 https://github.com/opencv/opencv_contrib/archive/refs/tags/4.5.3.zip \
    && unzip 4.5.3.zip && mkdir /opencv/opencv-4.5.3/build && cd /opencv/opencv-4.5.3/build \
    && cmake .. -DOPENCV_ENABLE_NONFREE=ON -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.5.3/modules/ \
	&& make -j12 && make install \
	&& rm -rf /opencv

# 迈德威视
WORKDIR /
COPY MindVisionSDK /MindVisionSDK
RUN cd /MindVisionSDK && ./install.sh && rm -rf /MindVisionSDK

# fmt安装配置
WORKDIR /
RUN git clone http://github.com/fmtlib/fmt.git && mkdir fmt/build && cd fmt/build \
	&& cmake .. && make -j 8 && make install && rm -rf /fmt

# spdlog手动安装
WORKDIR /
RUN git clone https://github.com/gabime/spdlog.git && mkdir spdlog/build && cd spdlog/build \
	&& cmake .. && make -j 8 && make install && rm -rf /spdlog

# ceres安装（eigen3）
WORKDIR /
RUN git clone https://ceres-solver.googlesource.com/ceres-solver && mkdir ceres-solver/ceres-bin/ && cd ceres-solver/ceres-bin && cmake .. && make -j8 && make test && make install && rm -rf /ceres-solver
           
# zsh安装与配置
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t jispwoso \
    -a HYPHEN_INSENSITIVE="true" \
    -a DISABLE_UNTRACKED_FILES_DIRTY="true" \
    -a COMPLETION_WAITING_DOTS="true" \
    -p git \
    -p z \
    -p colored-man-pages \
    -p sudo \
    -p extract \
    -p copypath \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
