#!/bin/bash
# build_ros2_jazzy_torch_matrix.sh

set -e

# Torch and ROS package matrix
TORCH_VERSIONS=(2.7.1 2.5.0)
ROS_PACKAGES=(ros-base desktop-full)

for TORCH_VERSION in "${TORCH_VERSIONS[@]}"; do
  for ROS_PACKAGE in "${ROS_PACKAGES[@]}"; do
    IMAGE_TAG="kinisirobotics/kinisi:ros2-jazzy-${ROS_PACKAGE}-torch-${TORCH_VERSION}-24.04"
    echo "\nBuilding image for torch $TORCH_VERSION and ROS package $ROS_PACKAGE..."
    docker buildx build \
      --push \
      --platform linux/amd64 \
      --build-arg BASE_IMAGE_TYPE= \
      --build-arg UBUNTU_VERSION=24.04 \
      --build-arg ROS_DISTRO=jazzy \
      --build-arg ROS_PACKAGE=$ROS_PACKAGE \
      --build-arg TORCH_VERSION=$TORCH_VERSION \
      --tag $IMAGE_TAG .
  done
done

echo "If you have not already, authenticate with: docker login"
