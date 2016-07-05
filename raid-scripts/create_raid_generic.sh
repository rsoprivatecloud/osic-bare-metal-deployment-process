#!/bin/bash

/usr/sbin/hpssacli rescan
SERIAL=$(/usr/sbin/hpssacli ctrl all show | grep sn: | cut -d: -f2 | sed 's@ @@g;s@)@@g')
# Delete all logical drives
/usr/sbin/hpssacli ctrl sn=${SERIAL} delete forced override
# Remove residual DM mappings and re-sync
/sbin/dmsetup remove_all --force
/sbin/dmsetup status
# Create OS RAID10 - all drives (placed at /dev/sda for preseed/kickstart)
/usr/sbin/hpssacli ctrl sn=${SERIAL} create type=ld raid=1+0 ss=256 drives=au size=max ca=enable
