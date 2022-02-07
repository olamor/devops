#!/bin/bash
sudo apt update
sudo apt install git
git clone https://github.com/olamor/devops.git
cd cd devops/ofpsql/
sudo sh ofpsql.sh
