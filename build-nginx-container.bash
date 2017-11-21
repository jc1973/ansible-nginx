#!/bin/bash 

virtualenv ansible-container
. /var/lib/jenkins/ansible-container/bin/activate
eval "$(chef shell-init bash)"
ansible-container build
ansible-container run
DOCKER_IMAGE=$(docker ps 2>/dev/null | grep nginx | awk '{print $1}')
inspec exec test/integration/default/inspec/default_spec.rb -t docker://${DOCKER_IMAGE}
