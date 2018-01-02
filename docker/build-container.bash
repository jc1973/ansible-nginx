#!/bin/bash

STATUS=0
D_TAG=$(git rev-parse --short ${GIT_COMMIT})
docker build -t hello-node:${D_TAG} . | tee build.info || STATUS=1
IMAGE_ID=$(grep 'Successfully built' build.info | awk '{print $NF}')
docker tag ${IMAGE_ID} johncartercap/hello-node:${D_TAG}
docker push johncartercap/hello-node
