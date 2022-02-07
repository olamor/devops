#!/bin/bash

sudo apt update -y
sudo apt install git -y
git clone https://github.com/olamor/devops.git
cd devops/jenpromgraf/
sudo sh jenpromgraf.sh