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
file_data_osm=$2"_france.osm.pbf"
url_data="https://s3.amazonaws.com/metro-extracts.mapzen.com/"$2"_france.osm.pbf"
sudo wget "$url_data"
sudo mv "$file_data_osm" import.osm.pbf
echo "$file_data_osm"
echo "OSM data imported"

# Launch the containers
cd ~
sudo wget https://raw.githubusercontent.com/brelevenix/OpenStreetMap-Tileserver-DockerCompose/master/docker-compose.yml
sudo docker-compose up -d
echo "containers running"
