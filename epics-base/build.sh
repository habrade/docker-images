#!/bin/bash
set -e

OS=linux

hw_platform=`uname -m`

if [[ $hw_platform == "armv7l" ]]; then
	TAG_HOST_ARCH=arm
elif  [[ $hw_platform == "x86_64" ]]; then
	TAG_HOST_ARCH=amd64
else
    echo "Error: Only suuport linux/amd64 and linux/arm platform!" 2>&1;
    exit 1;
fi

if [[ "$TAG_HOST_ARCH" == "arm" ]]; then
    BASE_IMG=raspbian/stretch
	variant=v7
    IMAGE_PLATFORM=$OS/$TAG_HOST_ARCH/$variant
	EPICS_HOST_ARCH=linux-arm
elif [[ "$TAG_HOST_ARCH" == "amd64" ]]; then
    BASE_IMG=debian:buster
    IMAGE_PLATFORM=$OS/$TAG_HOST_ARCH
	EPICS_HOST_ARCH=linux-x86_64
else
    echo "Error: Only suuport linux-x86_64 and linux-arm platform!" 2>&1;
    exit 1;
fi

CHANGE_MIRROR="ON"
if [[ $CHANGE_MIRROR == "ON" ]]; then
    DEBIAN_MIRROR="mirrors.ustc.edu.cn"
    DEBIAN_MIRROR_SECURITY="mirrors.ustc.edu.cn/debian-security"
    echo "[INFO] Debian Mirror is changed to ${DEBIAN_MIRROR}";
    echo "[INFO] Debian Security Mirror is changed to ${DEBIAN_MIRROR_SECURITY}";
else
    DEBIAN_MIRROR=""
    DEBIAN_MIRROR_SECURITY=""
fi

while IFS="" read -r base_version || [ -n "$base_version" ]
do
    VERSION=$base_version
    echo "Start build epics base $base_version on platform $IMAGE_PLATFORM";
    echo "The Base image is $BASE_IMG";
    DOCKER_BUILDKIT=1 docker build \
               --platform ${IMAGE_PLATFORM} \
               --build-arg DEBIAN_MIRROR=${DEBIAN_MIRROR} \
               --build-arg DEBIAN_MIRROR_SECURITY=${DEBIAN_MIRROR_SECURITY} \
               --build-arg BASE_IMG=${BASE_IMG} \
               --build-arg VERSION=${VERSION} \
               --build-arg EPICS_HOST_ARCH=${EPICS_HOST_ARCH} \
               -t habrade/epics-base:${VERSION}-$TAG_HOST_ARCH \
               ./
done < config.txt

echo "Done!"
