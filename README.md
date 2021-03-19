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


## Usage:
1.	Login to jump server with devops account
2.	Clone this git repository.
          $ git clone https://github.com/Moh-Aalim/kubernetes.git
3.	Run setup_kubernetes.sh
          $ cd kubernetes
          $ ./ setup_kubernetes.sh



#### Usage
                
+ Login to jump server with devops account
+ Clone this git repository.
    + $ git clone https://github.com/Moh-Aalim/kubernetes.git
    
+ Run setup_kubernetes.sh
    * $ cd kubernetes
    * $ ./ setup_kubernetes.sh
    
