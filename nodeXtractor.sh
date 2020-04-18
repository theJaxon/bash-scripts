#!/bin/bash
# List all files with .js extension in the current directory and store them in a variable
jsFiles=$(find . -type f -name "*.js" -printf "%f\n" )

# Loop through all the files, extract the module name and append it to a new file
# The pattern matches any string found between 
# require("    and    ")
for i in $jsFiles; do 
    cat $i | grep -o -P '(?<=require\(\").*(?=\"\))' >> moduleListTemp
done

# Awk adds 2 spaces a minus and anothe space for each line in the generated file preparing it to be placed in the vars section of the ansible playbook
awk '{print "  -  " $s}' moduleListTemp | sort | uniq > moduleList

# Remove the temporary file that stored the duplicated module names
rm -rf moduleListTemp