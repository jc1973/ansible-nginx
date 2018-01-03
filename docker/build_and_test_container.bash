#!/bin/bash

STATUS=0
export DOCKER_HOST='tcp://192.168.99.101:2375'
echo changed docker host
echo getting images
docker images
#D_TAG=$(git rev-parse --short ${GIT_COMMIT})
docker build -t hello-node:${GIT_COMMIT} . | tee build.info || STATUS=1
IMAGE_ID=$(grep 'Successfully built' build.info | awk '{print $NF}')
echo "Testing Image hello-node:${GIT_COMMIT}"
docker run hello-node:${GIT_COMMIT}
echo "Getting CONTAINER ID of hello-node:${GIT_COMMIT}"
CONTAINER_ID=$(DOCKER_HOST='tcp://192.168.99.101:2375' docker ps | grep "hello-node:${GIT_COMMIT}" | awk '{print $1}')
echo "CONTAINER_ID = ${CONTAINER_ID}"
exit 1
inspec exec test/integration/docker -t docker://${CONTAINER_ID} || STATUS=1
echo "Stopping the running container hello-node:${GIT_COMMIT}"
docker kill ${CONTAINER_ID}
# kill -9 $(ps -aef | grep "hello-node:${GIT_COMMIT}" | grep -v 'grep' | awk '{print $2'})

#docker tag ${IMAGE_ID} johncartercap/hello-node:${GIT_COMMIT}
#docker push johncartercap/hello-node
