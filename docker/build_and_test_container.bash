#!/bin/bash

STATUS=0
export DOCKER_HOST='tcp://192.168.99.101:2375'
#D_TAG=$(git rev-parse --short ${GIT_COMMIT})
docker build -t hello-node:${GIT_COMMIT} . | tee build.info || STATUS=1
IMAGE_ID=$(grep 'Successfully built' build.info | awk '{print $NF}')A
echo "Testing Image hello-node:${GIT_COMMIT}"
docker run hello-node:${GIT_COMMIT} &
inspec exec test/integration/docker -t docker://hello-node:${GIT_COMMIT} || STATUS=1
echo "Stopping the running container hello-node:${GIT_COMMIT}"
kill -9 $(ps -aef | grep "hello-node:${GIT_COMMIT}" | grep -v 'grep' | awk '{print $2'})

#docker tag ${IMAGE_ID} johncartercap/hello-node:${GIT_COMMIT}
#docker push johncartercap/hello-node
