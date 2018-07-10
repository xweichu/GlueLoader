#!/usr/bin/env bash
# [wf] execute run stage
client='xweichu@c240g1-031311.wisc.cloudlab.us'
ssh -p 22 $client << 'EOF'
    sudo apt-get --assume-yes install librbd-dev
    udo apt-get --assume-yes install ceph-common
    ceph osd pool create rbd  128 128
    ceph osd pool set rbd size 2
    ceph osd pool set rbd  min_size 1
    ceph osd pool application enable rbd rbd
    rbd -p rbd create --size 2048 fio_test
    echo "[global]
#logging
#write_iops_log=write_iops_log
#write_bw_log=write_bw_log
#write_lat_log=write_lat_log
ioengine=rbd
clientname=admin
pool=rbd
rbdname=fio_test
invalidate=0    # mandatory
rw=randwrite
bs=4k

[rbd_iodepth32]
iodepth=32" > test.fio

EOF

