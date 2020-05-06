#!/bin/bash

current_dir="$PWD"
generated_dir="$current_dir/generated"
template_dir="$current_dir/template"
echo "rm -rf $generated_dir" 
rm -rf $generated_dir
echo "mkdir -p $generated_dir"  
mkdir -p $generated_dir

cp -r $template_dir/*   $generated_dir

echo "replace placehold in $generated_dir/task-definition.json"  

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


IMAGE_URL=`cat config.json | jq .task.image`
replace="s!%%IMAGE_URL%%!$IMAGE_URL!g" 
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







