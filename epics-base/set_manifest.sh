#!/bin/bash
set -e

os=linux
arch=arm
variant=v7

MANIFEST_LIST=habrade/epics-base

while IFS="" read -r base_version || [ -n "$base_version" ]
do

	docker manifest create --amend  $MANIFEST_LIST:$base_version $MANIFEST_LIST:$base_version
	docker manifest annotate \
		--os $os \
		--arch $arch \
		--variant $variant \
		$MANIFEST_LIST:$base_version \
		habrade/epics-base:${base_version}
    echo "Push minifest: $MANIFEST_LIST:$base_version";
    docker manifest push $MANIFEST_LIST:$base_version
done < config.txt


