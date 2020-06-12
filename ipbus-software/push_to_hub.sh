#!/bin/bash
set -e

account=habrade

while IFS="" read -r VERSION || [ -n "$VERSION" ]
do
    repo_tag=$account/ipbus-software:$VERSION
    echo "Push ipbus-software:$VERSION to hub.docker.com";
    docker push $repo_tag
done < config.txt

echo "Done!"

