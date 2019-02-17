#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

CONTAINER=`docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $SCRIPTPATH/share:/root/share \
  ss0201/jenkins-unity:latest`

COMMAND_BASE="/opt/Unity/Editor/Unity -quit -batchmode -nographics"
COMMAND="cd ~ && \
         $COMMAND_BASE -manualLicenseFile /root/share/Unity_v2018.x.ulf && \
         $COMMAND_BASE"
docker exec $CONTAINER sh -c "$COMMAND"
