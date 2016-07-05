#!/bin/bash

# Remove LVM Logical Volume
umount /deleteme
lvchange -an /dev/mapper/lxc-deleteme00
lvremove -f /dev/mapper/lxc-deleteme00
rm -rf /deleteme

# Remove fstab entry
sed -i '/lxc-deleteme00/d' /etc/fstab
