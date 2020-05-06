#!/bin/bash
chmod 776 prebuild.sh
chmod 776 build.sh
./prebuild.sh
./build.sh $CLUSTER $servicename $REGION $imageUrl
echo Deploying Docker image to AWS Fargate on `date`
chmod 766 ecs-deploy
./ecs-deploy -c $CLUSTER -n $servicename  -r $REGION -p default  -i $imageUrl
echo start to deploy aws farget successfully


