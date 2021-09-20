# kubernetes on baremetal (ubuntu/debain)

## install docker

### Debain
```bash
# uninstall old version
sudo apt-get remove docker docker-engine docker.io containerd runc

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88,
# by searching for the last 8 characters of the fingerprint.
sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22

# add repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt-get update
sudo apt-get install -y docker-ce=5:18.09.9~3-0~debian-$(lsb_release -cs) \
  docker-ce-cli=5:18.09.9~3-0~debian-$(lsb_release -cs) containerd.io
```

### Ubuntu
ref: [Container runtimes#Docker](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker)
ref: [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

#### Uninstall old version
```bash
 sudo apt-get remove docker docker-engine docker.io containerd runc
```
#### Update Repo
1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:
```bash
 sudo apt-get update
 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
2. Add Docker’s official GPG key:
```bash
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

3. add stable repo
```bash
 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### Install docker
```bash
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io
```

#### Manage docker as non root
1. Create the docker group.
```bash
 sudo groupadd docker
```

2. Add your user to the docker group.
```bash
 sudo usermod -aG docker $USER
```

3. Log out and log back in so that your group membership is re-evaluated.

On Linux, you can also run the following command to activate the changes to groups:
```bash
 newgrp docker 
```

4. Verify that you can run docker commands without sudo.
```bash
 docker info
```

If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error, which indicates that your ~/.docker/ directory was created with incorrect permissions due to the sudo commands.

```bash
WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied
```

To fix this problem, either remove the ~/.docker/ directory (it is recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:
```bash
 sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
 sudo chmod g+rwx "$HOME/.docker" -R
```

#### Configure Docker to start on boot
```bash
 sudo systemctl enable docker.service
 sudo systemctl enable containerd.service
```

To disable this behavior, use disable instead.
```bash
 sudo systemctl disable docker.service
 sudo systemctl disable containerd.service
```

#### install `docker-compose`
```bash
 sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

```bash
 sudo chmod +x /usr/local/bin/docker-compose
```

Test the installation.
```bash
 docker-compose --version
 docker-compose version 1.29.2, build 5becea4c
```

#### Set up the Docker daemon
```bash
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d


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
sudo systemctl daemon-reload
sudo systemctl restart kubelet
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

## joining nodes
run
```bash
kubeadm token create --print-join-command
```

### setting node ip
```bash
sudo vim /sudo vim /var/lib/kubelet/config.yaml /var/lib/kubelet/kubeadm-flags.env

KUBELET_KUBEADM_ARGS=--cgroup-driver=systemd --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.1 --node-ip=10.10.10.1

systemctl daemon-reload && systemctl restart kubelet
```
ref: https://github.com/kubernetes/kubeadm/issues/203

--node-ip config

Add "--node-ip" to '/var/lib/kubelet/kubeadm-flags.env

```bash
cat /var/lib/kubelet/kubeadm-flags.env
KUBELET_KUBEADM_ARGS=--cgroup-driver=systemd --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.1 --node-ip=10.10.10.1
```

## setup storage
1. ref: [Kubernetes (5) Local Persistent Volumes](https://vocon-it.com/2018/12/20/kubernetes-local-persistent-volumes/)
    ```bash
    cat > storageClass.yaml << EOF
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
      name: my-local-storage
    provisioner: kubernetes.io/no-provisioner
    volumeBindingMode: WaitForFirstConsumer
    EOF

    kubectl create -f storageClass.yaml
    ```
