#!/bin/bash

if [[ $# -ne 1 ]]
then
  echo "Usage: $0 <username>" >&2
  exit 1
fi

PROJECT=insec
CLUSTER_DESC=insecure-cluster.yml
USER=$1

if [[ $user == "root" ]]
then
  command="bash -l"
else
  command="su - $USER"
fi

eval docker-compose -p $PROJECT -f $CLUSTER_DESC exec gateway1 $command
