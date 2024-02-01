# Following the book Core Kubernetes by Jay Vyas and Chris Love
#!/bin/bash

# Creating isolated process via chroot and copying the needed binaries into the desired chroot location
mkdir -pv /home/namespace/box/{bin,lib,proc,data}

cp -v /usr/bin/{kill,rm,ps} /home/namespace/box/bin/
cp -v /bin/{bash,ls} /home/namespace/box/bin/

cp -r /lib/* /home/namespace/box/lib/

mount -t proc /proc /home/namespace/box/proc

# Use /data as a temp directory inside the chrooted environment
mount --bind /tmp /home/namespace/box/data

# List files in the chrooted environment
chroot /home/namespace/box /bin/ls
