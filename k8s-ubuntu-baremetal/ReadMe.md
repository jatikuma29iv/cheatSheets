#

## install docker
ref: [Container runtimes#Docker](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker)
```bash
# (Install Docker CE)
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
apt-get update && apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add the Docker apt repository:
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# Install Docker CE
apt-get update && apt-get install -y \
  containerd.io=1.2.13-1 \
  docker-ce=5:19.03.8~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.8~3-0~ubuntu-$(lsb_release -cs)

# Set up the Docker daemon
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart Docker
systemctl daemon-reload
systemctl restart docker

```

## install k8s
ref: [Steps to Install Kubernetes on Ubuntu](https://phoenixnap.com/kb/install-kubernetes-on-ubuntu)

### install kubelet, kubeadm, kubectl
```bash
# set version
export myK8sVersion="1.14.10-00"

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet=$myK8sVersion kubeadm=$myK8sVersion kubectl=$myK8sVersion
sudo apt-mark hold kubelet kubeadm kubectl
```

Restarting the kubelet is required:
```bash
systemctl daemon-reload
systemctl restart kubelet
```

### Begin Kubernetes Deployment

Start by disabling the swap memory on each server:
```bash
sudo swapoff –a
```

### Assign Unique Hostname for Each Server Node 

Decide which server to set as the master node. Then enter the command:
```bash
sudo hostnamectl set-hostname master-node
```

## setup master
ref: [Creating a single control-plane cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
```bash
kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## fixing coredns

### for standalone master for development purposes
[ref](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#control-plane-node-isolation)
```bash
kubectl taint nodes --all node-role.kubernetes.io/master-
```

### for cluster master install add on
Installing a Pod network add-on ([ref](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network))
```bash
# calico
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
```
