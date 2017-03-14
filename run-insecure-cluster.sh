 #!/bin/bash

set -xe

PROJECT=insec
CLUSTER_FILE=insecure-cluster.yml

sudo rm -fr ./mysqld-data-dir
mkdir ./mysqld-data-dir
tar xzf $PROJECT-mysqld-data-dir.tgz -C mysqld-data-dir

docker-compose -p $PROJECT -f $CLUSTER_FILE up
exit

docker-compose -p $PROJECT -f $CLUSTER_FILE up -d db
sleep 120
docker-compose -p $PROJECT -f $CLUSTER_FILE up -d cm
sleep 240
docker-compose -p $PROJECT -f $CLUSTER_FILE up -d worker1 worker2 master1 gateway1
sleep 30
