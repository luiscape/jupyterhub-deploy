#!/bin/bash

apt-get install npm nodejs-legacy python3-pip git -y
npm install -g configurable-http-proxy

pip3 install jupyterhub notebook --upgrade

git clone https://github.com/jupyter/dockerspawner
cd dockerspawner \
  && pip3 install -r requirements.txt \
  && python3 setup.py install

docker build -t jupyter/systemuser systemuser