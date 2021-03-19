#!/usr/bin/bash
#
#
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

echo "############ Bootstrapping Kubernetes cluster ############"
kubeadm init

mkdir -p $HOME/.kube > /dev/null 2>&1
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config > /dev/null 2>&1
sudo chown $(id -u):$(id -g) $HOME/.kube/config > /dev/null 2>&1

mkdir -p /home/devops/.kube > /dev/null 2>&1
cp -i /etc/kubernetes/admin.conf /home/devops/.kube/config > /dev/null 2>&1
sudo chown -R devops:devops /home/devops/.kube > /dev/null 2>&1

echo "############ Installing Pod Network pluggin (Calico) ############"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl get nodes

exit 0
