#!/bin/bash
yum update -y
yum install -y python3 git
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

cd /home/ec2-user

git clone https://github.com/faiz1487/flask-node-docker-project.git
cd backend
pip3 install -r requirements.txt
nohup python3 app.py &

cd ../frontend
npm install
nohup node server.js &
