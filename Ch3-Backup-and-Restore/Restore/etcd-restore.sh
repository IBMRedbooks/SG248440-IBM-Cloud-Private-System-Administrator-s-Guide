#!/bin/bash
[ -z "$1" ] && { echo "Please provide the etcd snapshot file name"; exit 1; }
data_dir="/var/lib/etcd"
restore_dir="/var/lib/etcd/restored"

# Get etcd docker image details
[ -z $etcd_image ] && etcd_image=$(grep '"image"' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g' -e 's/--//g' -e 's/image://g')

# Set volume mounts
volume_mounts="-v $(pwd):/data -v /etc/cfc/conf/etcd:/certs -v /var/lib/etcd:/var/lib/etcd"
self=$(grep 'advertise-client-urls=' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g')

# Get etcd cluster settings
node_name=$(grep 'name=' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g')
initial_advertise_peer_urls=$(grep 'initial-advertise-peer-urls=' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g')
initial_cluster=$(grep 'initial-cluster=' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g')
initial_cluster_token=$(grep 'initial-cluster-token=' /etc/cfc/podbackup/etcd.json  | sed -e 's/^\s*//' -e 's/\",//g' -e 's/\"//g')

# Delete the etcd data
rm -rf /var/lib/etcd

# Run the restore on the node
docker run --entrypoint=etcdctl -e ETCDCTL_API=3 ${volume_mounts} ${etcd_image} --cert /certs/client.pem --key /certs/client-key.pem --cacert /certs/ca.pem --endpoints ${self} snapshot restore /data/$1 --data-dir=$restore_dir $node_name $initial_advertise_peer_urls $initial_cluster_token $initial_cluster

# Print result
[ $? -eq 0 ] && echo "etcd restore successful" || echo "etcd restore failed"