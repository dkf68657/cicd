#!/bin/bash

function getConfigValue(){
  local key = "$1"
  local result = `cat config.json | jq $key`
  return $result
}

current_dir="$PWD"
generated_dir="$current_dir/generated"
template_dir="$current_dir/template"
echo "rm -rf $generated_dir" 
rm -rf $generated_dir
echo "mkdir -p $generated_dir"  
mkdir -p $generated_dir

cp -r $template_dir/*   $generated_dir

echo "replace placehold in $generated_dir/task-definition.json"  


task_family=$(getConfigValue .task.family)
echo $task_family

replace="s/%%FAMILY%%/$task_family/g" 
sed -i -e $replace $generated_dir/task-definition.json





