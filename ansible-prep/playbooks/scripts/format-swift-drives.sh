#!/bin/bash

apt-get -qq update; apt-get install -y xfsprogs

# Create XFS labels (modify [b-g] with proper disks being added to swift) and create mountpoints
COUNT=1; for i in $(lsblk -f | awk '/sd[b-g]/ {print $1}'); \
    do mkfs.xfs -f -L disk${COUNT} -i size=1024 /dev/$i \
    && mkdir -p /srv/node/disk${COUNT}; ((COUNT++)); done

# Add above output to /etc/fstab
OPTIONS="defaults,noatime,nodiratime,nobarrier,logbufs=8"
blkid | sort | grep xfs | while read line; \
    do DISK_NAME=$(echo "$line" | awk -F\" '{print $2}'); \
    echo -e "LABEL=\"${DISK_NAME}\"\t/srv/node/${DISK_NAME}\txfs\t${OPTIONS}\t0 0"; done >> /etc/fstab

mount -a
