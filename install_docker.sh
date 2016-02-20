#!/bin/bash

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update

sudo apt-get install docker-engine=${1}-0~$(lsb_release -cs) -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

echo 'DOCKER_OPTS="$DOCKER_OPTS -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry=127.0.0.1:5000"' >> /etc/default/docker

sudo stop docker || true
sudo start docker
