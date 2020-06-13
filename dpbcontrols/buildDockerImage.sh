#!/usr/bin/env bash

eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

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

PRJ_NAME=dpbcontrols
IPBUS_VERSION=v2.6.3

DOCKER_BUILDKIT=1 docker build \
    --pull \
    --ssh default \
    --build-arg DEBIAN_MIRROR=${DEBIAN_MIRROR} \
    --build-arg DEBIAN_MIRROR_SECURITY=${DEBIAN_MIRROR_SECURITY} \
    --build-arg IPBUS_VERSION=${IPBUS_VERSION} \
    --progress=plain \
    -t habrade/${PRJ_NAME}:latest \
    ./