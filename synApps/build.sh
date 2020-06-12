#!/bin/bash

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

PRJ_NAME=epics-synapps
TAG_NAME=latest

DOCKER_BUILDKIT=1 docker build \
    --no-cache \
    --pull \
    --build-arg DEBIAN_MIRROR=${DEBIAN_MIRROR} \
    --build-arg DEBIAN_MIRROR_SECURITY=${DEBIAN_MIRROR_SECURITY} \
    -t habrade/$PRJ_NAME:$TAG_NAME \
    ./