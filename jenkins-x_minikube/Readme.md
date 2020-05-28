# Jenkins X on minikube

## minikube

 |<!-- --> |<!-- -->|
 |---|---|
 |OS |OSX/Mac |
 |minikube |latest |
 |driver |virtualbox |
 |kubernetes |1.14.10 |
 |cri | docker |
 
  ### install minikube
  ```bash
  minikube start --cpus=6 --memory=8192 --kubernetes-version=1.14.10 --vm-driver=virtualbox
  ```

## Jenkins X
 |<!-- --> |<!-- -->|
 |---|---|
 |jx | latest |
 |provider | kubernets |
 |doman | on premise |
 
  ### Patch
  ```bash
   kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
   kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# edit docker registry
$ kubectl edit cm jenkins-x-docker-registry -n jx
 
# load balancer
$ kubectl patch svc jxing-nginx-ingress-controller -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.99.101"]}}' -n kube-system
   
   kubectl patch svc  -n kube-system jxing-nginx-ingress-controller \
      -p '{"spec": {"type": "LoadBalancer", "externalIPs":["$EXTERNAL_IP"]}}'
   kubectl patch svc  -n kube-system jxing-nginx-ingress-controller \
      -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.99.104"]}}'
   kubectl patch deployments -n kube-system jxing-nginx-ingress-controller \
      -p '[{"op":"add","path":"/spec/template/spec/containers/0/livenessProbe/timeoutSeconds",
      "value":10},
      {"op":"add","path":"/spec/template/spec/containers/0/readinessProbe/timeoutSeconds",
      "value":10}]' --type=json
   kubectl patch deployments -n kube-system jxing-nginx-ingress-controller \
      -p '{"spec":{"replicas":1}}'

   kubectl patch deployments -n jx deck -p '{"spec":{"replicas":1}}'

   kubectl patch deployments -n jx hook -p '{"spec":{"replicas":1}}'

   kubectl patch deployments -n jx jenkins \
      -p '[{"op":"add",
      "path":"/spec/template/spec/containers/0/livenessProbe/initialDelaySeconds",
      "value":1200},
      {"op":"add",
      "path":"/spec/template/spec/containers/0/readinessProbe/initialDelaySeconds",
      "value":1140}]' --type=json

  kubectl patch deployments -n jx jenkins-x-nexus \
     -p '[{"op":"add",
        "path":"/spec/template/spec/containers/0/livenessProbe/initialDelaySeconds",
        "value":1200},
        {"op":"add","path":"/spec/template/spec/containers/0/readinessProbe/initialDelaySeconds",
        "value":1140},
        {"op":"add","path":"/spec/template/spec/containers/0/livenessProbe/timeoutSeconds",
        "value":10},
        {"op":"add","path":"/spec/template/spec/containers/0/readinessProbe/timeoutSeconds",
        "value":10}]' --type=json
  
   kubectl patch ds -n kube-system ksync \
      -p '[{"op":"add","path":"/spec/template/spec/containers/1/livenessProbe/timeoutSeconds",
      "value":10},
      {"op":"add","path":"/spec/template/spec/containers/1/readinessProbe/timeoutSeconds",
      "value":10}]' --type=json
   
   kubectl get deployment jenkins -o=jsonpath='{.spec.template.spec.containers[0].livenessProbe.initialDelaySeconds}' -n jx
   kubectl get deployment jenkins -o=jsonpath='{.spec.template.spec.containers[0].readinessProbe.initialDelaySeconds}' -n jx
  ```
  
  ## Devpod
  ```
helmins() {
 kubectl -n kube-system create serviceaccount tiller
 kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
 helm init --service-account=tiller --client-only
}
helmdel() {
 kubectl -n kube-system delete deployment tiller-deploy
 kubectl delete clusterrolebinding tiller
 kubectl -n kube-system delete serviceaccount tiller
 
}

# skafold 0.22.0
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/v0.22.0/skaffold-linux-amd64 && chmod +x skaffold
install skaffold /usr/bin/
```
