#!/bin/bash

STATUS=0
D_TAG=$(git rev-parse --short ${GIT_COMMIT})
docker build -t hello-node:${D_TAG} . || STATUS=1


