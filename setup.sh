#!/bin/bash
cd ./ITP4113_Code
docker pull martin605/web 
gcloud config set compute/zone asia-east1-a 
gcloud container clusters create web 
gcloud config set container/cluster web 
gcloud container node-pools describe default-pool 
gcloud container node-pools create custom --num-nodes 2 --image-type ubuntu 
gcloud container clusters update web --enable-autoscaling --min-nodes=3 --max-nodes=10 --node-pool=default-pool 
kubectl apply -f mailhog-deployment.yaml,mailhog-service.yaml,web-deployment.yaml,web-service.yaml,web-pod.yaml 
