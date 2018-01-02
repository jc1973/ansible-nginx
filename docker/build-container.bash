#!/bin/bash

STATUS=0
docker build -t hello-node:v1 . || STATUS=1


