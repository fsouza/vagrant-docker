#!/bin/bash

release=$(lsb_release -cs)
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-${release} main" | tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get dist-upgrade -y

apt-get install docker-engine=${1}-0~${release} -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

sed -i 's;^ExecStart=.*;ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --insecure-registry=127.0.0.1:5000 --insecure-registry=192.168.50.4:5000;' /lib/systemd/system/docker.service

systemctl daemon-reload
systemctl stop docker || true
systemctl start docker
usermod -G docker ubuntu
