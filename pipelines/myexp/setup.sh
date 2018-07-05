#!/usr/bin/env bash
# [wf] execute setup stage

# address of mon,mgr and osd1, osd2
server_mon='xweichu@c240g1-031305.wisc.cloudlab.us'

# address of osd_3 and osd_4
server_osd34='xweichu@c240g1-031307.wisc.cloudlab.us'

# address of osd_5 and osd_6
server_osd56='xweichu@c240g1-031309.wisc.cloudlab.us'

# address of osd_7 and osd_8
server_osd78='xweichu@c240g1-031313.wisc.cloudlab.us'

# address of client
client='xweichu@c240g1-031311.wisc.cloudlab.us'

ssh -p 22 $server_mon << 'EOF'
    sudo apt-get --assume-yes update;
    sudo apt-get --assume-yes install docker.io;
    sudo apt-get --assume-yes install vim;
    ip_addr=$(ifconfig enp2s0f0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://');
    sudo docker run -d --net=host --name=mon -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -e MON_IP=$ip_addr -e CEPH_PUBLIC_NETWORK=$ip_addr/24 ceph/daemon mon;
    sudo docker run -d --net=host --name=osd1 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdb  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd2 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdc  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd9 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdd  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd13 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sde  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=mgr -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph/ -e CEPHS_CREAT=1 ceph/daemon mgr
    sudo chmod -R 777 /etc/ceph/
    sudo chmod -R 777 /var/lib/ceph/
EOF

mkdir ceph_keys
scp $server_mon:/etc/ceph/* ./ceph_keys
scp $server_mon:/var/lib/ceph/bootstrap-osd/* ./ceph_keys


ssh -p 22 $server_osd34 << 'EOF'
    sudo apt-get --assume-yes update;
    sudo apt-get --assume-yes install docker.io;
    sudo apt-get --assume-yes install vim;
    sudo mkdir -p /etc/ceph/
    sudo mkdir -p /var/lib/ceph/bootstrap-osd/
    sudo chmod -R 777 /etc/ceph/
    sudo chmod -R 777 /var/lib/ceph/bootstrap-osd/
EOF

scp ./ceph_keys/* $server_osd34:/etc/ceph
scp ./ceph_keys/* $server_osd34:/var/lib/ceph/bootstrap-osd

ssh -p 22 $server_osd34 << 'EOF'
    sudo docker run -d --net=host --name=osd3 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdb  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd4 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdf  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd10 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdd  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd14 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sde  ceph/daemon osd_ceph_disk;
EOF


ssh -p 22 $server_osd56 << 'EOF'
    sudo apt-get --assume-yes update;
    sudo apt-get --assume-yes install docker.io;
    sudo apt-get --assume-yes install vim;
    sudo mkdir -p /etc/ceph/
    sudo mkdir -p /var/lib/ceph/bootstrap-osd/
    sudo chmod -R 777 /etc/ceph/
    sudo chmod -R 777 /var/lib/ceph/bootstrap-osd/
EOF

scp ./ceph_keys/* $server_osd56:/etc/ceph
scp ./ceph_keys/* $server_osd56:/var/lib/ceph/bootstrap-osd

ssh -p 22 $server_osd56 << 'EOF'
    sudo docker run -d --net=host --name=osd5 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdb  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd6 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdc  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd11 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdd  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd15 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sde  ceph/daemon osd_ceph_disk;
EOF

ssh -p 22 $server_osd78 << 'EOF'
    sudo apt-get --assume-yes update;
    sudo apt-get --assume-yes install docker.io;
    sudo apt-get --assume-yes install vim;
    sudo mkdir -p /etc/ceph/
    sudo mkdir -p /var/lib/ceph/bootstrap-osd/
    sudo chmod -R 777 /etc/ceph/
    sudo chmod -R 777 /var/lib/ceph/bootstrap-osd/
EOF

scp ./ceph_keys/* $server_osd78:/etc/ceph
scp ./ceph_keys/* $server_osd78:/var/lib/ceph/bootstrap-osd

ssh -p 22 $server_osd78 << 'EOF'
    sudo docker run -d --net=host --name=osd7 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdb  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd8 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdc  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd12 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sdd  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=osd16 --privileged=true -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph -v /dev/:/dev/ -e OSD_DEVICE=/dev/sde  ceph/daemon osd_ceph_disk;
    sudo docker run -d --net=host --name=mds -v /etc/ceph:/etc/ceph -v /var/lib/ceph/:/var/lib/ceph/ -e CEPHS_CREAT=1 ceph/daemon mds
EOF

ssh -p 22 $server_mon << 'EOF'
    sudo docker exec mon ceph osd pool create cephfsdata 128 128
    sudo docker exec mon ceph osd pool create cephfsmeta 128 128
    sudo docker exec mon ceph osd pool set cephfsdata size 2
    sudo docker exec mon ceph osd pool set cephfsdata min_size 1
    sudo docker exec mon ceph osd pool set cephfsmeta size 2
    sudo docker exec mon ceph osd pool set cephfsmeta min_size 1
    sudo docker exec  mon ceph fs new cephfs cephfsmeta cephfsdata
EOF

ssh -p 22 $client << 'EOF'
    sudo apt-get --assume-yes update;
    sudo apt-get --assume-yes install docker.io;
    sudo apt-get --assume-yes install vim;
    sudo apt-get --assume-yes install ceph-fuse;
    sudo mkdir -p /etc/ceph/
    sudo mkdir -p /var/lib/ceph/bootstrap-osd/
    sudo mkdir /mnt/cephfs/
    sudo chmod -R 777 /etc/ceph/
    sudo chmod -R 777 /var/lib/ceph/bootstrap-osd/
    sudo chmod -R 777 /mnt/cephfs/
EOF

scp ./ceph_keys/* $client:/etc/ceph
scp ./ceph_keys/* $client:/var/lib/ceph/bootstrap-osd
scp ~/Google\ Drive/Personal/Key/* $client:/users/xweichu/.ssh

ssh -p 22 $client << 'EOF'
    sudo ceph-fuse -k /etc/ceph/ceph.client.admin.keyring -c /etc/ceph/ceph.conf /mnt/cephfs
    eval "$(ssh-agent -s)"
    ssh-add -k ~/.ssh/id_rsa
    sudo chmod 777 /mnt/cephfs/
    scp cross@pulpo-dtn.ucsc.edu:/mnt/pulpos/cross/wdmerger_for_ucsc/* /mnt/cephfs
    scp cross@pulpo-dtn.ucsc.edu:/mnt/pulpos/cross/wdmerger_for_ucsc_2/* /mnt/cephfs
EOF
