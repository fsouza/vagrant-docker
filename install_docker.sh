#!/bin/bash

release=$(lsb_release -cs)
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-${release} main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update

sudo apt-get install docker-engine=${1}-0~${release} -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

sudo sed -i 's;^ExecStart=.*;ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --insecure-registry=127.0.0.1:5000 --insecure-registry=192.168.50.4:5000;' /lib/systemd/system/docker.service

sudo systemctl daemon-reload
sudo systemctl stop docker || true
sudo systemctl start docker
sudo usermod -G docker ubuntu
