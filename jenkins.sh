#!/bin/bash
set -e 
CLUSTER=`cat config.json | jq .service.cluster | sed 's/\"//g'`
servicename=`cat config.json | jq .service.name| sed 's/\"//g'`
REGION=`cat config.json | jq .task.region | sed 's/\"//g'`
imageUrl=`cat config.json | jq .task.image| sed 's/\"//g'` 
DESIRED_COUNT=`cat config.json | jq .service.desiredcount | sed 's/\"//g'`

chmod 776 prebuild.sh
chmod 776 build.sh
./prebuild.sh
./build.sh $CLUSTER $servicename $REGION $imageUrl
echo Deploying Docker image to AWS Fargate on `date`
echo "ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl -D $DESIRED_COUNT"
chmod 766 ecs-deploy
./ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl -D $DESIRED_COUNT

if [ $? -ne 0 ]; then
 echo deploy aws farget failed
 exit 1
fi
echo start to deploy aws farget successfully


