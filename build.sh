#!/bin/bash

echo `pwd`
echo mvn clean package
mvn clean package -Dmaven.test.skip=true
rm -f ./app/*.jar
cp ./target/cicd-0.0.1-SNAPSHOT.jar ./app/app.jar
current_dir="$(cd $(dirname $0); pwd)"
cluster=$1
servicename=$2
region=$3
docker_repo=$4

if [ -z cluster -o -z servicename -o -z region -o -z docker_repo ]; then
  echo "missing required parameters"
  exit 1
fi

echo Build started on `date`

echo Building the Docker image...

sudo docker build app/ -t cicd:latest

if [ $? -ne 0 ]; then
   echo docker build failed
   exit 1;
fi

echo Building the Docker image successfully

echo start tag docker image cicd:latest

sudo docker tag cicd:latest $docker_repo

echo Logging in to docker hub

sudo docker login

echo ----Logging in to docker hub successfully------

echo -------start push docker image to docker hub------

sudo docker push $docker_repo

echo Completed pushing Docker image. 

