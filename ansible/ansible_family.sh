#!/bin/bash
echo -n "Enter role name: "
read role_name

# Create parent directory
mkdir -v "${role_name}_family" && cd $_

# Create tasks and vars directory 
mkdir -v vars tasks 

supported_os=(Archlinux Debian RedHat Windows)
for os in "${supported_os[@]}"
do 
task_name="${role_name}-${os}"
var_name="$os"
touch "tasks/${task_name}.yml" "vars/${var_name}.yml"
done
