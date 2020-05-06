#!/bin/bash

current_dir="$PWD"
generated_dir="$current_dir/generated"
template_dir="$current_dir/template"
echo "rm -rf $generated_dir" 
rm -rf $generated_dir
echo "mkdir -p $generated_dir"  
mkdir -p $generated_dir

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

containerName=`cat config.json | jq .task.name`
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

servicename=`cat config.json | jq .serice.name`
replace="s!%%SERVICE_NAME%%!$servicename!g" 
sed -i -e $replace $generated_dir/service-definition.json

CLUSTER=`cat config.json | jq .serice.cluster`
replace="s!%%CLUSTER%%!$CLUSTER!g" 
sed -i -e $replace $generated_dir/service-definition.json


DESIRED_COUNT=`cat config.json | jq .serice.desiredcount`
replace="s!%%DESIRED_COUNT%%!$DESIRED_COUNT!g" 
sed -i -e $replace $generated_dir/service-definition.json

SECURITY_GROUP_ID=`cat config.json | jq .serice.desiredcount`
replace="s!%%SECURITY_GROUP_ID%%!$securitycroups!g" 
sed -i -e $replace $generated_dir/service-definition.json

SUBNETS=`cat config.json | jq .serice.subnets`
replace="s!%%SUBNETS%%!$SUBNETS!g" 
sed -i -e $replace $generated_dir/service-definition.json

TASK_NAME=`cat config.json | jq .serice.taskdefinition`
replace="s!%%TASK_NAME%%!$TASK_NAME!g" 
sed -i -e $replace $generated_dir/service-definition.json


PORT=`cat config.json | jq .serice.port`
replace="s!%%PORT%%!$PORT!g" 
sed -i -e $replace $generated_dir/service-definition.json

CONTAINER_NAME=`cat config.json | jq .serice.containername`
replace="s!%%CONTAINER_NAME%%!$CONTAINER_NAME!g" 
sed -i -e $replace $generated_dir/service-definition.json


TARGET_GROUP_ARN=`cat config.json | jq .serice.targetgrouparn`
replace="s!%%TARGET_GROUP_ARN%%!$TARGET_GROUP_ARN!g" 
sed -i -e $replace $generated_dir/service-definition.json

echo "----replace placehold in $generated_dir/service-definition.json end---"  


