# ITP4113_Code

This repository is use to create web on Docker or gcp with Kubernetes Engine.

# Docker
## Setup
>Please check  you Docker is installed

    git clone https://github.com/Martin605/ITP4113_Code.git
    docker pull martin605/web
    sudo docker swarm init
    docker stack deploy --compose-file  ./ITP4113_Code/docker-compose.yml  webstack
    docker stack services webstack

## Clean up
    sudo docker stack rm webstack
    sudo docker swarm leave --force
# For Kubernetes

## One Line command deploy

RUN the flowing command to run

    `git clone https://github.com/Martin605/ITP4113_Code.git  ; chmod +x ./ITP4113_Code/* ; sed -i 's/PASSWORD@IP/##DB_PASSWORD_HERE##@##DB_IP_HERE##/g' web-pod.yaml ; ./ITP4113_Code/setup.sh`

> Please change database information at`##DB_PASSWORD_HERE##`and`##DB_IP_HERE##`
## Setup Guideline

Step 1 	Start Cloud Shell and run the following command to download file. 

    cd ~
    git clone https://github.com/Martin605/ITP4113_Code.git
    docker pull martin605/web



Step 2 	In Cloud Shell, Run the following command to crate and config clusters.

    gcloud config set compute/zone asia-east1-a
    gcloud container clusters create web
    gcloud config set container/cluster web
    gcloud container node-pools describe default-pool
    gcloud container node-pools create custom --num-nodes 2 --image-type ubuntu
    gcloud container clusters update web --enable-autoscaling --min-nodes=3 --max-nodes=10 --node-pool=default-pool


Step 3 	In Cloud Shell, Run the following command to crate and config database server.

    gcloud sql instances create webdb --tier=db-g1-small --region=asia-east1 --root-password=PASSWORD --database-version=MYSQL_5_7

Step 4 	Run the following command to run config and setup.

    cd ITP4113_Code
    sed -i 's/#####PASSWORD@###IP/___PASSWORD___@_IP_/g' web-pod.yaml
    kubectl apply -f mailhog-deployment.yaml,mailhog-service.yaml,web-deployment.yaml,web-service.yaml,web-pod.yaml

> Replace `___PASSWORD___` to your database password and `_IP_` to your IP of database server

Step 5 	Clean up all clusters.

    cd ~/ITP4113_Code
    kubectl delete -f mailhog-deployment.yaml,mailhog-service.yaml,web-deployment.yaml,web-service.yaml,web-pod.yaml
    gcloud sql instances delete webdb
    gcloud container clusters delete web

