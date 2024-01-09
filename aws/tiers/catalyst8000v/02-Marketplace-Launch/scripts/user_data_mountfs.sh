#!/bin/bash
# Use this to mount the data volume on the Cisco Catalyst 8000v controller and node
yum update -y

# Install necessary utilities, if not already installed
yum install -y xfsprogs e2fsprogs

# Create a file system on the EBS volume (assuming the volume is attached as /dev/xvdf)
# Check if the volume has a file system
if [ "$(file -s /dev/xvdf)" == "/dev/xvdf: data" ]
then
    # No file system, create one
    mkfs -t ext4 /dev/xvdf
fi

# Create a mount point
mkdir /data

# Backup fstab
cp /etc/fstab /etc/fstab.bak

# Add entry to fstab to auto-mount on reboot
echo "/dev/xvdf /data ext4 defaults,nofail 0 2" >> /etc/fstab

# Mount the volume
mount -a