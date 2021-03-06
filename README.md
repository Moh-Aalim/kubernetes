# Kubernetes setup on RHEL8.3 EC2 instances running on AWS

## Description: 
This repository is used to build kubernetes cluster on RHEL8.3 EC2 instances running on AWS. This cluster has single master node and 2 worker nodes. I have created bash script to build this cluster.


## Prerequisite:
1.	All server are running on RHEL8.3.
2.	User devops is created on all servers with sudo to root privilege.
3.	Jump server has password-less ssh connectivity to all servers.
4.	Security Group is allowed all inbound connections.
5.	Security Enhanced Linux is disabled in all nodes to avoid SE related issues.
6.	FirewallD is disabled for the ease of the setup.
7.	All servers are hardcoded in kubernetes-prep.sh

## Current infra details
                    
Server Name   | IP Address
------------- | -------------
jump-server   | 172.31.4.6
k8s-master    | 172.31.4.9 
k8s-node01    | 172.31.1.75 
k8s-node02    | 172.31.3.117 


## Usage
                
+ Login to jump server with devops account
+ Clone this git repository.
    + $ git clone https://github.com/Moh-Aalim/kubernetes.git
    
+ Run setup_kubernetes.sh
    * $ cd kubernetes
    * $ ./setup_kubernetes.sh
    
