#!/bin/bash

./script/prebuild.sh
./script/build.sh

echo Deploying Docker image to AWS Fargate on `date`
chmod 766  script/ecs-deploy
./script/ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl
echo start to deploy aws farget successfully


