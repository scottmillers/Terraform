#!/bin/zsh
##
## Connect to the hub VM
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${WEBSERVER_IP}


