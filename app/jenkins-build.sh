#!/bin/bash

cluster=$1
servicename=$2
region=$3
docker_repo=$4
if [ -z cluster -o -z servicename -o -z region -o -z docker_repo ]; then
  echo "missing required parameters"
  exit 1
fi
echo current user :$(whoami)

echo Build started on `date`

echo Building the Docker image...

sudo docker build . -t cicd:latest

echo Building the Docker image successfully

echo start tag docker image cicd:latest

sudo docker tag cicd:latest brucedong1987/cicd:latest

echo Logging in to docker hub

sudo docker login

echo ----Logging in to docker hub successfully------

echo -------start push docker image to docker hub------

sudo docker push $docker_repo

echo Completed pushing Docker image ----. 
echo Deploying Docker image to AWS Fargate on `date`

chmod 766  ecs-deploy

#./ecs-deploy -c $cluster -n $servicename  -r $region -p default  -i $docker_repo


echo start to deploy aws farget successfully

