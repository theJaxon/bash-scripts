# BashScripts
 
 [![Bash Shell](https://badges.frapsoft.com/bash/v1/bash-150x25.png?v=103)](https://github.com/ellerbrock/open-source-badges/)
 
My collection of bash scripts.

---

* :file_folder: Ansible
  * /ansible_family.sh
  
The purpose of `ansible_family.sh` script is to generate the desired files to be used in a role.

When porting roles to run on different platforms one relies on facts like:
  - `ansible_facts['os_family']` which is generic so distros like (CentOS, Fedora and RHEL) all fall under **RedHat** Family.
  - `ansible_facts['distribution']` which is more specific so the fact returns the name of the distribution (Ubuntu, Fedora and so on)
  
  The main.yml file in the tasks directory looks like the following (This tip is from Jeff Geerling book named ansible for DevOps):
  
```yml
- name: Include variables based on OS Family 
  include_vars: "{{ ansible_facts['os_family'] }}.yml"

- name: Include tasks based on OS Family 
  include_tasks: "<role_name>-{{ ansible_facts['os_family'] }}.yml"
```
So whenever the playbook runs it gathers the facts and only the files matching those facts get included.
This script generates the desired files to be used in the include_vars and include_tasks section.

#### Example:
```bash
./ansible_family.sh
Enter role name: chrome
# mkdir: created directory 'chrome_family'
# mkdir: created directory 'vars'
# mkdir: created directory 'tasks' 

ls -R chrome_family

chrome_family/:
tasks  vars

chrome_family/tasks:
chrome-Archlinux.yml  chrome-Debian.yml  chrome-RedHat.yml  chrome-Windows.yml

chrome_family/vars:
Archlinux.yml  Debian.yml  RedHat.yml  Windows.yml
```
