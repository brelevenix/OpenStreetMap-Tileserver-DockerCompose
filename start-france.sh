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
sudo wget http://download.geofabrik.de/europe/france/guadeloupe-latest.osm.pbf
sudo wget http://download.geofabrik.de/europe/france/guyane-latest.osm.pbf
sudo wget http://download.geofabrik.de/europe/france/martinique-latest.osm.pbf
sudo wget http://download.geofabrik.de/europe/france/mayotte-latest.osm.pbf
sudo wget http://download.geofabrik.de/europe/france/reunion-latest.osm.pbf
sudo wget http://download.geofabrik.de/australia-oceania/new-caledonia-latest.osm.pbf
echo "OSM data imported"

# Merge files
sudo osmosis --read-pbf guadeloupe-latest.osm.pbf --read-pbf guyane-latest.osm.pbf --read-pbf martinique-latest.osm.pbf --merge --merge --write-pbf import.osm.pbf

# Launch the containers
cd ~
sudo wget -O docker-compose.yml https://raw.githubusercontent.com/brelevenix/OpenStreetMap-Tileserver-DockerCompose/master/docker-compose-france.yml
sudo docker-compose up -d
echo "containers running"
