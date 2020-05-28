# k8s
```bash
# countdown
$ function countdn() { local i=$1; while [ "$i" -gt "0" ]; do printf "\r repeating after $i sec"; i=`expr $i - 1`; sleep 1; done; echo . }

# alias syntax highlighted less
$ alias cless="/usr/local/bin/ccat --color='always' | less -R"

# busypods
$ while true; do kubectl get pods -A --sort-by=.metadata.creationTimestamp | grep -v Running | grep -v Completed | tail -r; echo ""; countdn 60; done #getbusypods
```

# jx

## patches
```bash
TODO

- tls config in k9s


Node-Selectors:  <none>                                                                                                                                                                                                                     │
│Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s                                                                                                                                                                            │
│                 node.kubernetes.io/unreachable:NoExecute for 300s                                                                                                                                                                          │
│Events:                                                                                                                                                                                                                                     │
│  Type     Reason  Age                     From             Message                                                                                                                                                                         │
│  ----     ------  ----                    ----             -------                                                                                                                                                                         │
│  Normal   Pulled  6m50s (x599 over 137m)  kubelet, master  Container image "gcr.io/jenkinsxio/jenkinsx:0.0.81" already present on machine                                                                                                  │
│  Warning  Failed  114s (x622 over 137m)   kubelet, master  Error: Couldn't find key docker.registry in ConfigMap jx/jenkins-x-docker-registry


curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 K3S_NODE_NAME="master" INSTALL_K3S_EXEC="server --tls-san 192.168.33.10 --advertise-address 192.168.33.10" sudo sh - \
      && sleep 10 \
      && sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/.kube/config \
      && sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/.kube/



jx install --provider=kubernetes --external-ip=$iJX_IP \
--on-premise \
--domain=$iJX_IP.nip.io \
--default-admin-password="admin123" \
--git-username=craft.de.jet@gmail.com --username="craft.de.jet@gmail.com" \
--default-environment-prefix="k3s-ubuntu" \
--git-api-token=c75ca4b918f262d9c3f84dc9f154628c52851633


# minikube

## install
minikube start --cpus=6 --memory=8192 --kubernetes-version=1.14.10 --vm-driver=virtualbox

if installing inside a vm
minikube start --provider=none --apiserver-ips=192.168.xx.yy --kubernetes-version=1.14.10

Jenkins x

* retrigger
If you then promote to the Staging environment or retrigger the pipeline on the master branch of your Staging git repository (e.g. via jx start pipeline) then you should see the output of the exposecontroller(https://github.com/jenkins-x/exposecontroller) pod.


sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.0.2.15:80
sudo iptables -t nat -A POSTROUTING -p tcp -d 10.0.2.15 --dport 80 -j SNAT --to-source 192.168.55.10
sudo iptables-save

kubectl patch svc jxing-nginx-ingress-controller -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.55.10"]}}' -n kube-system

# tekton

## installation


https://github.com/tektoncd/pipeline/blob/master/docs/install.md

`deployment tekton-pipelines-controller`

`svc tekton-pipelines-controller`

VIM
https://medium.com/@jeantimex/how-to-configure-iterm2-and-vim-like-a-pro-on-macos-e303d25d5b5c

# kubernetes

## delete node
`kubectl get nodes

1) First drain the node

`kubectl drain <node-name>`
You might have to ignore daemonsets and local-data in the machine

`kubectl drain <node-name> --ignore-daemonsets --delete-local-data`
2) Edit instance group for nodes (Only if you are using kops)

kops edit ig nodes
Set the MIN and MAX size to whatever it is -1 Just save the file (nothing extra to be done)

You still might see some pods in the drained node that are related to daemonsets like networking plugin, fluentd for logs, kubedns/coredns etc

3) Finally delete the node

`kubectl delete node <node-name>`
4) Commit the state for KOPS in s3: (Only if you are using kops)

`kops update cluster --yes`
OR (if you are using kubeadm)

If you are using kubeadm and would like to reset the machine to a state which was there before running kubeadm join then run

`kubeadm reset`


https://www.jenkins.io/doc/pipeline/tour/getting-started/
https://github.com/jenkinsci/docker
https://github.com/jenkins-x/jenkins-x-image/blob/master/Dockerfile

aa601fa943d0 cd8765175d6b 1354e6989bbf 7c888b0c6dcc 25925e13601e


kubectl patch deploy -n jx-edit-jatikuma29iv pegasus-spring-pegasus-spring \
    -p '[{"op":"add",
      "path":"/spec/template/spec/containers/0/livenessProbe/initialDelaySeconds",
      "value":1200},
      {"op":"add","path":"/spec/template/spec/containers/0/readinessProbe/initialDelaySeconds",
      "value":1140},
      {"op":"add","path":"/spec/template/spec/containers/0/livenessProbe/timeoutSeconds",
      "value":10},
      {"op":"add","path":"/spec/template/spec/containers/0/readinessProbe/timeoutSeconds",
      "value":10}]' --type=json


```
