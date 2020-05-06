#!/bin/bash
current_dir="$(cd $(dirname $0); pwd)"
generated_dir="$current_dir/generated"
template_dir="$current_dir/template"
echo "rm -rf $generated_dir" 
echo `whoami`
rm -f $generated_dir/*
#echo "mkdir -p $generated_dir"  
#mkdir -p $generated_dir

cp -r $template_dir/*   $generated_dir

echo "----replace placehold in $generated_dir/task-definition.json start---"  

task_family=`cat config.json | jq .task.family`
replace="s/%%FAMILY%%/$task_family/g" 
sed -i -e $replace $generated_dir/task-definition.json

ecsServiceRole=`cat config.json | jq .task.executionrolearn`
replace="s!%%EcsServiceRole%%!$ecsServiceRole!g" 
sed -i -e $replace $generated_dir/task-definition.json

ecsTaskRole=`cat config.json | jq .task.taskRolearn`
replace="s!%%ECSTaskRole%%!$ecsTaskRole!g" 
sed -i -e $replace $generated_dir/task-definition.json

containerName=`cat config.json | jq .task.containername`
replace="s!%%ContainerName%%!$containerName!g" 
sed -i -e $replace $generated_dir/task-definition.json


imageUrl=`cat config.json | jq .task.image`
replace="s!%%IMAGE_URL%%!$imageUrl!g" 
sed -i -e $replace $generated_dir/task-definition.json


PORT=`cat config.json | jq .task.port`
replace="s/%%PORT%%/$PORT/g" 
sed -i -e $replace $generated_dir/task-definition.json

LOG_GROUP=`cat config.json | jq .task.loggroup`
replace="s/%%LOG_GROUP%%/$LOG_GROUP/g" 
sed -i -e $replace $generated_dir/task-definition.json

REGION=`cat config.json | jq .task.region`
replace="s/%%REGION%%/$REGION/g" 
sed -i -e $replace $generated_dir/task-definition.json


STREAM_PREFIX=`cat config.json | jq .task.streamprefix`
replace="s/%%STREAM_PREFIX%%/$STREAM_PREFIX/g" 
sed -i -e $replace $generated_dir/task-definition.json

echo  "---replace placehold in $generated_dir/task-definition.json end----"  

echo "----replace placehold in $generated_dir/service-definition.json start---"  

servicename=`cat config.json | jq .service.name`
replace="s!%%SERVICE_NAME%%!$servicename!g" 
sed -i -e $replace $generated_dir/service-definition.json

CLUSTER=`cat config.json | jq .service.cluster`
replace="s!%%CLUSTER%%!$CLUSTER!g" 
sed -i -e $replace $generated_dir/service-definition.json


DESIRED_COUNT=`cat config.json | jq .service.desiredcount`
replace="s!%%DESIRED_COUNT%%!$DESIRED_COUNT!g" 
sed -i -e $replace $generated_dir/service-definition.json

SECURITY_GROUP_ID=`cat config.json | jq .service.securitycroups`
replace="s!%%SECURITY_GROUP_ID%%!$SECURITY_GROUP_ID!g" 
sed -i -e $replace $generated_dir/service-definition.json

subnet1=`cat config.json | jq .service.subnet1`
replace="s!%%subnet1%%!$subnet1!g" 
sed -i -e $replace $generated_dir/service-definition.json

subnet2=`cat config.json | jq .service.subnet2`
replace="s!%%subnet2%%!$subnet2!g" 
sed -i -e $replace $generated_dir/service-definition.json

TASK_NAME=`cat config.json | jq .service.taskdefinition`
replace="s!%%TASK_NAME%%!$TASK_NAME!g" 
sed -i -e $replace $generated_dir/service-definition.json


PORT=`cat config.json | jq .service.containerport`
replace="s!%%PORT%%!$PORT!g" 
sed -i -e $replace $generated_dir/service-definition.json

CONTAINER_NAME=`cat config.json | jq .service.containername`
replace="s!%%CONTAINER_NAME%%!$CONTAINER_NAME!g" 
sed -i -e $replace $generated_dir/service-definition.json


TARGET_GROUP_ARN=`cat config.json | jq .service.targetgrouparn`
replace="s!%%TARGET_GROUP_ARN%%!$TARGET_GROUP_ARN!g" 
sed -i -e $replace $generated_dir/service-definition.json

echo "----replace placehold in $generated_dir/service-definition.json end---"  

#echo "aws ecs register-task-definition --cli-input-json file://$generated_dir/task-definition.json"
#aws ecs register-task-definition --cli-input-json file://$generated_dir/task-definition.json

echo "aws ecs describe-services --service $(echo $servicename|sed 's/\"//g') --cluster $(echo $CLUSTER|sed 's/\"//g') --region $(echo $REGION|sed 's/\"//g') | jq .services[].status"
status=`aws ecs describe-services --service $(echo $servicename|sed 's/\"//g') --cluster $(echo $CLUSTER|sed 's/\"//g') --region $(echo $REGION|sed 's/\"//g') | jq .services[].status`
echo "----$status----"
if [ "$status" == '"INACTIVE"' ] || [ -z $status  ]; then
  echo "create a new service aws ecs create-service --cli-input-json file://$generated_dir/service-definition.json "
  aws ecs create-service --cli-input-json file://$generated_dir/service-definition.json
else
  echo "service $servicename has existed, skip the service creating phrase"
fi  