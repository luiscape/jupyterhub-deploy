#!/bin/bash

yum update \
  && yum install openssl-devel bzip2-devel expat-devel \
                 gdbm-devel readline-devel sqlite-devel -y

curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install nodejs -y
yum install gcc-c++ make -y

#
#  Install Python via Anaconda.
#
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh

npm install -g configurable-http-proxy

pip install jupyter notebook jupyterhub