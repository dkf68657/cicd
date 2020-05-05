#!/bin/bash

cd ./app

echo Build started on `date`

echo Building the Docker image...

sudo docker build . -t cicd:latest

echo Building the Docker image successfully

echo start tag docker image cicd:latest

sudo docker tag cicd:latest 082651270708.dkr.ecr.us-east-1.amazonaws.com/cicd:latest


echo Logging in to Amazon ECR...

sudo $(aws ecr get-login --no-include-email --region us-east-1)

echo ----Logging in to Amazon ECR successfully------

echo start push docker image to ecr

sudo docker push 082651270708.dkr.ecr.us-east-1.amazonaws.com/cicd:latest

echo Completed pushing Docker image. Deploying Docker image to AWS Fargate on `date`

printf '[{"name":"cicdservice","imageUri":"%s"}]' 082651270708.dkr.ecr.us-east-1.amazonaws.com/cicd:latest > ../imagedefinitions.json
