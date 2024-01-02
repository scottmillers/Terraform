#!/bin/bash

# Install nginxte
sudo yum update -y

sudo yum install -y git amazon-linux-extras
sudo amazon-linux-extras install nginx1


# Start nginx
sudo service nginx start


# Deploy Tetris game
cd /usr/share/nginx/html
sudo git clone https://github.com/jakesgordon/javascript-tetris.git tetris


# Set permissions for Tetris game files
sudo chown -R nginx:nginx /usr/share/nginx/html/tetris/


# Restart Nginx
sudo service nginx restart

