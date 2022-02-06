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


echo "=================================
      Installing Jenkins ...
================================="



apt-get update -y
apt install openjdk-11-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt install ca-certificates -y
apt-get update -y
apt-get install jenkins -y

echo "================================================
      Installing Prometheus and Grafana ...
================================================" 
docker-compose up 