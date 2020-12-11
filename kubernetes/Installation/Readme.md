# Installation

## config sample
```yaml
# config.yaml
kind: ClusterConfiguration
clusterName: "<cluster_name>"
apiServer:
  certSANs:
    - <ip>
    - <ip>
networking:
  podSubnet: 10.244.0.0/16
---
apiVersion: kubeadm.k8s.io/v1beta1
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: "<ip>"
```

usage:
`kubeadm --config config.yaml`

## join node
```bash
kubeadm token create --print-join-command
```
## merge config/context
```bash
KUBECONFIG=$HOME/.kube/config:<path/of/new/config> kubectl config view --flatten > mergedconfig
mv mergedconfig .kube/config
```
