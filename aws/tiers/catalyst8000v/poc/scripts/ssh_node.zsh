#!/bin/zsh
##
## Connect to the Cisco Catalyst8000V Node
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${NODE_IP}


