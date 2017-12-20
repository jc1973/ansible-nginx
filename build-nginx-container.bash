#!/bin/bash 

STATUS=0

. /var/lib/jenkins/ansible-container/bin/activate || STATUS=1
[ $STATUS  -eq 1 ] && echo cannot set up python virtual environment
[ $STATUS  -eq 1 ] && exit $STATUS

ansible-container build || STATUS=1
[ $STATUS  -eq 1 ] && echo cannot build container with ansbile-container build
[ $STATUS  -eq 1 ] && exit $STATUS

ansible-container run || STATUS=1
[ $STATUS  -eq 1 ] && echo cannot run container with ansbile-container run
[ $STATUS  -eq 1 ] && ansible-container destroy
[ $STATUS  -eq 1 ] && exit $STATUS

DOCKER_IMAGE=$(docker ps 2>/dev/null | grep nginx | awk '{print $1}') || STATUS=1
[ $STATUS  -eq 1 ] && echo cannot get docker image id 
[ $STATUS  -eq 1 ] && ansible-container destroy
[ $STATUS  -eq 1 ] && exit $STATUS

# We do not need to install the chefDK for inspec to work
which chef
if [ $? -eq 0 ]; then
  eval "$(chef shell-init bash)" || STATUS=1
  [ $STATUS  -eq 1 ] && echo cannot set up test environment
  [ $STATUS  -eq 1 ] && ansible-container destroy
  [ $STATUS  -eq 1 ] && exit $STATUS
fi

inspec exec test/integration/default/inspec/default_spec.rb -t docker://${DOCKER_IMAGE} || STATUS=1
[ $STATUS  -eq 1 ] && echo tests failed
[ $STATUS  -eq 1 ] && ansible-container destroy
[ $STATUS  -eq 1 ] && exit $STATUS

ansible-container destroy || STATUS=1
[ $STATUS  -eq 1 ] && echo cannot destroy container with ansbile-container destroy
exit ${STATUS}
