#!/bin/bash

set -e

docker buildx build --push \
    --platform linux/amd64 \
    --build-arg IMAGE_VERSION=v25.07 \
    --build-arg BASE_IMAGE_TYPE="-tensorrt" \
    --build-arg UBUNTU_VERSION="24.04" \
    --build-arg ROS_DISTRO="jazzy" \
    --build-arg ROS_PACKAGE="desktop-full" \
    --build-arg ROS_BUILD_FROM_SRC="false" \
    --build-arg TORCH_VERSION="2.5.0" \
    --build-arg TF_VERSION="2.18.0" \
    --build-arg ONNX_RUNTIME_VERSION="1.20.1" \
    --build-arg TRITON_VERSION="2.52.0" \
    --tag kinisirobotics/ros2-ml:jazzy-desktop-full-tf2.18.0-torch2.5.0-v25.07
