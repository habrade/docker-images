#!/bin/bash
set -e

hw_platform=`uname -m`

if [[ $hw_platform == "armv7l" ]]; then
	TAG_HOST_ARCH=arm
elif  [[ $hw_platform == "x86_64" ]]; then
	TAG_HOST_ARCH=amd64
else
    echo "Error: Only suuport linux/amd64 and linux/arm platform!" 2>&1;
    exit 1;
fi

while IFS="" read -r base_version || [ -n "$base_version" ]
do
    echo "Push epics-base:$base_version-$TAG_HOST_ARCH to hub.docker.com";
    docker push habrade/epics-base:$base_version-$TAG_HOST_ARCH
done < config.txt

echo "Done!"

