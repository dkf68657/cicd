#!/bin/bash

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

sudo docker push brucedong1987/cicd:latest

echo Completed pushing Docker image ----. 
echo Deploying Docker image to AWS Fargate on `date`

chmod 766  ecs-deploy

./ecs-deploy -c cicdcluster -n cicdservice  -r us-east-1 -p default  -i brucedong1987/cicd:latest


echo start to deploy aws farget successfully

