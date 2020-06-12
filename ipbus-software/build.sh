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

while IFS="" read -r VERSION || [ -n "$VERSION" ]
do
    tag=habrade/ipbus-software:$VERSION
    echo "[INFO] Start build image: $tag ...";   
    DOCKER_BUILDKIT=1 docker build \
        --no-cache \
        --pull \
        --build-arg DEBIAN_MIRROR=${DEBIAN_MIRROR} \
        --build-arg DEBIAN_MIRROR_SECURITY=${DEBIAN_MIRROR_SECURITY} \
        --build-arg VERSION=$VERSION \
        -t habrade/ipbus-software:$VERSION \
        ./
done < config.txt

echo "[INFO] Done!"
