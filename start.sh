#!/bin/sh
# Initialise VM with all required code
# Docker, Docker-Compose, Import file

# Install docker
curl -o install.sh -sSL https://get.docker.com/
sudo sh install.sh
sudo groupadd docker
sudo gpasswd -a cloud docker
sudo service docker restart
echo "docker installed and running"

# Install docker-compose
sudo apt-get -y install python-pip
sudo pip install docker-compose
echo "docker-compose installed"

# Import OSM data
cd ~
sudo mkdir osm
cd osm
sudo wget http://download.geofabrik.de/europe/france/bretagne-latest.osm.pbf
sudo mv bretagne-latest.osm.pbf import.osm.pbf
echo "OSM data imported"

# Launch the containers
cd ~
sudo wget https://raw.githubusercontent.com/brelevenix/OpenStreetMap-Tileserver-DockerCompose/master/docker-compose.yml
sudo docker-compose up -d
echo "containers running"
