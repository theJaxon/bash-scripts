# nodeXtractor

The goal was to find all the names of packages required within any `.js` file, extract those names and append them to an ansible playbook that will do the installation using npm globally.

### Example:
file content of 2 js files 
![cat](https://github.com/theJaxon/BashScripts/blob/master/etc/nodeXtractor/1-JS-cat.jpg)
 
after running the script, the desired output is a list that can be added to ansible `/vars` file

![output](https://github.com/theJaxon/BashScripts/blob/master/etc/nodeXtractor/2-Xtracted.jpg)
