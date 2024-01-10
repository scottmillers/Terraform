#!/bin/zsh
##
## Connect to the Simulated TIERS web server
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${WEBSERVER_IP}


