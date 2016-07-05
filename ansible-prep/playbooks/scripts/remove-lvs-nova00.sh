#!/bin/bash

# Remove LVM Logical Volume
umount /var/lib/nova
lvchange -an /dev/mapper/lxc-nova00
lvremove -f /dev/mapper/lxc-nova00
rm -rf /var/lib/nova

# Remove fstab entry
sed -i '/lxc-nova00/d' /etc/fstab
