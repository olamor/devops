#!/bin/bash

sudo -s
apt update
apt install git
git clone https://github.com/olamor/devops.git
cd devops/ofpsql/
sh ofpsql.sh
