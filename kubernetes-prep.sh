#!/usr/bin/bash
#

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

echo "Setting-up /etc/hosts"
cat <<EOF>> /etc/hosts
172.31.4.9 k8s-master
172.31.1.75 k8s-node01
172.31.3.117 k8s-node02
EOF
echo "Disabling SE-Linux"
setenforce 0 > /dev/null 2>&1
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
echo "Disabling FirewallD"
systemctl disable firewalld > /dev/null 2>&1
systemctl stop firewalld > /dev/null 2>&1
modprobe br_netfilter > /dev/null 2>&1
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables > /dev/null 2>&1
echo "Installing Docker"
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
dnf install docker-ce iptables -y > /dev/null 2>&1
systemctl enable docker > /dev/null 2>&1
systemctl start docker > /dev/null 2>&1
docker info > /dev/null 2>&1
if [ $? -eq 0 ] 
then 
	echo "Docker has been installed successfully"
else
	echo "Docker installation has some issue, please check"
fi
echo "Installing Kubernetes"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
dnf install kubeadm -y  > /dev/null 2>&1
systemctl enable kubelet  > /dev/null 2>&1
systemctl start kubelet  > /dev/null 2>&1
if [ $? -eq 0 ] 
then 
	echo "Kubernetes has been installed successfully"
else
	echo "Kubernetes installation has some issue, please check"
fi
echo "Turning off swap"
swapoff -a  > /dev/null 2>&1
sed -i '/ swap / s/^/#/' /etc/fstab
