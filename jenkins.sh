#!/bin/bash

CLUSTER=`cat config.json | jq .service.cluster`
servicename=`cat config.json | jq .service.name`
REGION=`cat config.json | jq .task.region |sed 's/\"//g'`
imageUrl=`cat config.json | jq .task.image|sed 's/\"//g'` 

chmod 776 prebuild.sh
chmod 776 build.sh
./prebuild.sh
./build.sh $CLUSTER $servicename $REGION $imageUrl
echo Deploying Docker image to AWS Fargate on `date`
echo "ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl"
chmod 766 ecs-deploy
./ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl
echo start to deploy aws farget successfully


