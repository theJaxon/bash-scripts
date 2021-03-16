#!/bin/bash

# Enable amazon extras and install nginx 
amazon-linux-extras install -y nginx1

# Enable and start nginx service
systemctl enable --now nginx 