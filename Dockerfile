FROM nvidia/opengl:1.2-glvnd-devel-ubuntu16.04

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ARG DEBIAN_FRONTEND=noninteractive

# Dependencies          
RUN apt-get update -y && \
    apt-get install -y sudo unzip git vim libeigen3-dev wget build-essential gdb curl cmake \
    libgtk2.0-dev pkg-config
RUN apt-get install -y lsb-release &&\
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' &&\
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - &&\
    apt-get update -y &&\
    apt install -y ros-kinetic-desktop-full
RUN rosdep init && rosdep update

RUN apt-get update \
    && apt-get install -y curl git \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y ros-kinetic-navigation \
    && apt-get install -y ros-kinetic-robot-localization \
    && apt-get install -y ros-kinetic-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:borglab/gtsam-release-4.0 \
    && apt-get update \
    && apt install -y libgtsam-dev libgtsam-unstable-dev \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN mkdir -p ~/catkin_ws/src \
    && cd ~/catkin_ws/src \
    && git clone https://github.com/dbparkJ/LIO-SAM-nvidia-docker.git \
    && cd .. \
    && source /opt/ros/kinetic/setup.bash \
    && catkin_make

RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

WORKDIR /root/catkin_ws
