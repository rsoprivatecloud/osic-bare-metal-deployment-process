#!/bin/bash

/usr/sbin/hpssacli rescan
SERIAL=$(/usr/sbin/hpssacli ctrl all show | grep sn: | cut -d: -f2 | sed 's@ @@g;s@)@@g')
/usr/sbin/hpssacli ctrl sn=${SERIAL} delete forced override
/sbin/dmsetup remove_all --force
/sbin/dmsetup status
# Logicaldrive 1 - OS RAID1 - drives 1I:1:1,1I:1:2
/usr/sbin/hpssacli ctrl sn=${SERIAL} create type=ld raid=1 ss=256 drives=1I:1:1,1I:1:2 size=max ca=enable
# Logicaldrive 2 - Cinder RAID10 - drives 1I:1:3,1I:1:4,1I:1:5,1I:1:6,1I:1:7,1I:1:8,2I:2:1,2I:2:2,2I:2:3,2I:2:4
/usr/sbin/hpssacli ctrl sn=${SERIAL} create type=ld raid=1+0 ss=256 drives=1I:1:3,1I:1:4,1I:1:5,1I:1:6,1I:1:7,1I:1:8,2I:2:1,2I:2:2,2I:2:3,2I:2:4 size=max ca=enable
