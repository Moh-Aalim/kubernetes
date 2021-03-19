#!/usr/bin/bash
#
USER=devops
MASTER=k8s-master
WORKER1=k8s-node01
WORKER2=k8s-node02

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

echo "Copying setup scripts on the kubernetes nodes"
scp kubernetes-master.sh kubernetes-prep.sh nginx.yaml $USER@$MASTER:/home/devops/
scp kubernetes-prep.sh $USER@$WORKER1:/home/devops/
scp kubernetes-prep.sh $USER@$WORKER2:/home/devops/

echo "Installing Docker and Kubernetes packages"
ssh -t $USER@$MASTER "sudo /home/devops/kubernetes-prep.sh"
ssh -t $USER@$WORKER1 "sudo /home/devops/kubernetes-prep.sh"
ssh -t $USER@$WORKER2 "sudo /home/devops/kubernetes-prep.sh"

echo "Bootstrapping Kubernetes cluster"
ssh -t $USER@$MASTER "sudo /home/devops/kubernetes-master.sh"
echo "Cluster has been built successfully"

mkdir -p $HOME/.kube
scp $USER@$MASTER:/home/devops/.kube/config $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo "Done"

echo "Joining worker node `hostname` in Kubernetes Cluster"
JOIN_CMD=$(ssh devops@k8s-master "kubeadm token create --print-join-command")
ssh -t $USER@$WORKER1 "sudo $JOIN_CMD"
ssh -t $USER@$WORKER2 "sudo $JOIN_CMD"
echo "Done"

echo "Deploying nginx webserver"
ssh $USER@$MASTER kubectl apply -f /home/devops/nginx.yaml


echo "checking webserver"
curl $MASTER:30080

exit 0

