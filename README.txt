This setup contains 2 docker clusters with Cloudera Manager setup in it. One is insecure, the other is the same cluster after _some_ steps have been taken to secure it.

This is NOT meant to be used in production of any kind. This is NOT meant to serve as a reference-architecture. It is merely meant as a toy setup for you to play along with the Strata Hadoop World talk on 'How to secure your Apache Hadoop Cluster'

To use this, first setup a machine with a large amount of RAM and a good number of cores. I have gotten good results with 60GB/16cores. You may try smaller if you like, but don't go too small -- your're runnig a full cluster on your box. Obviously, make sure you can reach this box via TCP (arbitrary ports) using any mechanism (via VPN, ssh tunneling, etc.). If you're up for it, get _two_ such boxes up: one for running the insecure cluster and one for the secure cluster. (You can't run both clusters as the same time as currently written)

Setup and configure docker (https://docs.docker.com/engine/getstarted/) and docker compose (https://docs.docker.com/compose/install/)

Clone the github repo https://github.com/manishahluwalia/shw-sjc-2017-demo-cluster.git

Then, run the insecure cluster with:

./run-insecure-cluster.sh

This will start up the cluster using docker compose. Hit Ctrl-C to terminate the cluster.


While the cluster is running, you can:
- log into the cloudera manager console. This will be at http://your.hostname:7180. Username/password is admin/admin
- get a shell as one of the users on one of the nodes in the cluster. You get this via:  
    ./cluster-shell.sh <user-name>
  Where user-name is one of the valid users on the box (see below)
- log into Hue UI at http://your.hostname:8888


All clusters have the following:
- user hdfs_admin, part of cdh_admin group
- user kms_admin, part of cdh_admin group
- user alice, part of cdh_users group
- user bob, part of cdh_users group
The password (unix and kerberos) for all the users is 'hadoop'

All clusters have the following nodes:
- db.cluster: MySQL DB, used by CM and CDH
- kdc.cluster: The KDC. Not used in the insecure cluster, but there for you to configure CM/CDH against
- dns.cluster: 
- cm.cluster: The CM node
- {worker1,worker2,master1,gateway1}.cluster: Nodes that run CDH components

