client='xweichu@c240g1-031305.wisc.cloudlab.us'
ssh -p 22 $client << 'EOF'
    mkdir /mnt/cephfs/FIO/0.5MB
    mkdir /mnt/cephfs/FIO/1MB
    mkdir /mnt/cephfs/FIO/2MB
    mkdir /mnt/cephfs/FIO/4MB
    mkdir /mnt/cephfs/FIO/8MB
    mkdir /mnt/cephfs/FIO/16MB
    mkdir /mnt/cephfs/FIO/32MB
    mkdir /mnt/cephfs/FIO/64MB
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=524288 stripe_count=1 object_size=524288 pool=cephfsdata" /mnt/cephfs/FIO/0.5MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=1048576 stripe_count=1 object_size=1048576 pool=cephfsdata" /mnt/cephfs/FIO/1MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=2097152 stripe_count=1 object_size=2097152 pool=cephfsdata" /mnt/cephfs/FIO/2MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=4194304 stripe_count=1 object_size=4194304 pool=cephfsdata" /mnt/cephfs/FIO/4MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=8388608 stripe_count=1 object_size=8388608 pool=cephfsdata" /mnt/cephfs/FIO/8MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=16777216 stripe_count=1 object_size=16777216 pool=cephfsdata" /mnt/cephfs/FIO/16MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=33554432 stripe_count=1 object_size=33554432 pool=cephfsdata" /mnt/cephfs/FIO/32MB/
    sudo setfattr -n ceph.dir.layout -v "stripe_unit=67108864 stripe_count=1 object_size=67108864 pool=cephfsdata" /mnt/cephfs/FIO/64MB/
EOF