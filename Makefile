#
#  JUPYTER HUB DEPLOY
#  ------------------
#
#  This program deploys a JupyterHub
#
#    - build: builds Docker image
#    - run: runs Docker image
#
#  Author: Luis Capelo <luis.capelo@flowminder.org>
#
LOCAL_PORT = 80
VERSION = v0.1.0

build:
	docker build -t jupyterhub:$(VERSION) .

run:
	docker run \
			--name jupyterhub \
			-p $(LOCAL_PORT):8000 \
			-d jupyterhub