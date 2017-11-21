#!/bin/bash 

. ansible-container/bin/activate
eval "$(chef shell-init bash)"
cd ansible-nginx/
ansible-container build
ansible-container run

