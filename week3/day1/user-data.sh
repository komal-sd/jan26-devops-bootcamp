#!/bin/bash
sleep 30

sudo yum update -y
sudo yum install git python3 -y

cd /home/ec2-user
git clone https://github.com/komal-sd/jan26-devops-bootcamp.git

cd jan26-devops-bootcamp/week3/day1/app
chmod +x run.sh
./run.sh
