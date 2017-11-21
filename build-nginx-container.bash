#!/bin/bash 

virtualenv ansible-container
. /var/lib/jenkins/ansible-container/bin/activate
eval "$(chef shell-init bash)"
ansible-container build
ansible-container run

