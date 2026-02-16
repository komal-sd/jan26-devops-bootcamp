#!/bin/bash
yum update -y
yum install git python3 -y

cd /home/ec2-user
git clone https://github.com/komal-sd/jan26-devops-bootcamp-.git

cd jan26-devops-bootcamp/week3/day1
pip3 install -r requirements.txt

nohup python3 app.py > app.log 2>&1 &
