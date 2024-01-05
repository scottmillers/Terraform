#!/bin/zsh
##
## Connect to the hub VM
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${CISCO8000V_CONTROLLER_IP}


