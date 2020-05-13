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
   kubectl patch svc  -n kube-system jxing-nginx-ingress-controller \
      -p '{"spec": {"type": "LoadBalancer", "externalIPs":["$EXTERNAL_IP"]}}'

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

   kubectl get deployment jenkins -o=jsonpath='{.spec.template.spec.containers[0].livenessProbe.initialDelaySeconds}' -n jx
   kubectl get deployment jenkins -o=jsonpath='{.spec.template.spec.containers[0].readinessProbe.initialDelaySeconds}' -n jx
  ```
