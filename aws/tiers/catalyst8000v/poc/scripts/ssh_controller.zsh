#!/bin/zsh
##
## Connect to the Cisco Catalyst8000V Controller
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${CONTROLLER_IP}


