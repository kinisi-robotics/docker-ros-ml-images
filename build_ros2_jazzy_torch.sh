#!/bin/bash
# build_ros2_jazzy_torch.sh

set -e


# Build and push for multiple torch versions

# Build and push multi-arch images for each torch version

# Publish all images to Docker Hub
# for TORCH_VERSION in 1.7.1 2.5.0 2.6.0 2.5.1; do
#   LOCAL_TAG="ghcr.io/kinisi-robotics/ros1-jazzy-torch-${TORCH_VERSION}:24.04"
#   DOCKERHUB_TAG="ghcr.io/kinisirobotics/ros1-jazzy-torch-${TORCH_VERSION}:24.04"
#   echo "\nPushing $LOCAL_TAG to Docker Hub as $DOCKERHUB_TAG..."
#   docker tag $LOCAL_TAG $DOCKERHUB_TAG
#   docker push $DOCKERHUB_TAG
# done


for TORCH_VERSION in 2.7.1 2.5.0 2.6.0 2.5.1; do
  DOCKERHUB_TAG="kinisirobotics/kinisi:ros2-jazzy-torch-${TORCH_VERSION}:24.04"
  echo "\nBuilding multi-arch image for torch version $TORCH_VERSION..."
  docker buildx build \
    --push \
    --platform linux/amd64 \
    --build-arg BASE_IMAGE_TYPE= \
    --build-arg UBUNTU_VERSION=24.04 \
    --build-arg ROS_DISTRO=jazzy \
    --build-arg ROS_PACKAGE=ros-base \
    --build-arg TORCH_VERSION=$TORCH_VERSION \
    --tag $DOCKERHUB_TAG .
done

echo "If you have not already, authenticate with: docker login ghcr.io"


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

for TORCH_VERSION in 2.5.0; do
  IMAGE_TAG="kinisirobotics/kinisi:ros2-jazzy-torch-${TORCH_VERSION}-24.04"
  echo "Building multi-arch image for torch version $TORCH_VERSION..."
  docker buildx build \
    --push \
    --platform linux/amd64 \
    --build-arg BASE_IMAGE_TYPE= \
    --build-arg UBUNTU_VERSION=24.04 \
    --build-arg ROS_DISTRO=jazzy \
    --build-arg ROS_PACKAGE=ros-base \
    --build-arg TORCH_VERSION=$TORCH_VERSION \
    --tag $IMAGE_TAG .
done


for TORCH_VERSION in 2.7.1; do
  IMAGE_TAG="kinisirobotics/kinisi:ros2-desktop-jazzy-torch-${TORCH_VERSION}-24.04"
  echo "Building multi-arch image for torch version $TORCH_VERSION..."
  docker buildx build \
    --push --progress plain \
    --platform linux/amd64 \
    --build-arg BASE_IMAGE_TYPE= \
    --build-arg UBUNTU_VERSION=24.04 \
    --build-arg ROS_DISTRO=jazzy \
    --build-arg ROS_PACKAGE=desktop-full \
    --build-arg TORCH_VERSION=$TORCH_VERSION \
    --tag $IMAGE_TAG .
done






