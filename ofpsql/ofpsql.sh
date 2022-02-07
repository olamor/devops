#!/bin/bash
sudo -i
echo "=================================
      Installing Docker ...
================================="

sleep 2

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "=================================
      Installed successfully
=================================
         run test ..."

sleep 2

docker run hello-world

echo "=================================
  Installing Docker Compose ...
================================="

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "=================================
      Installed successfully
=================================
         view version ..."

sleep 2

docker-compose --version

sudo docker run -d -p 9100:9100  -v "/:/host:ro,rslave" --name=node_exporter quay.io/prometheus/node-exporter --path.rootfs /host

echo "==================================================
      Installing Openfire and PostgreSQL ...
==================================================" 
docker-compose up
