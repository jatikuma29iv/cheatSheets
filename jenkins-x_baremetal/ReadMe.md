# jx

## install jx

## download `jx-requirements.yml` template
```bash
# update mycluster,192.168.0.1,mygitusername & with your values

curl -Ls https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/jenkins-x_baremetal/jx-requirements.yml \
| sed 's/YOUR_CLUSTER_NAME/mycluster/' \
| sed 's/YOUR_CLUSTER_IP/192.168.0.1/' \
| sed 's/YOUR_GIT_USERNAME/mygitusername/' \
| sed 's/YOUR_NAMESPACE/jx/' > jx-requirements.yml
```

## setup jx
```bash
jx boot -r jx-requirements.yml
```

*note: incase you have to restart the boot process due to error*
```bash
cd jenkins-x-boot-config
jx boot -r ../jx-requirements.yml
```
you can also use flag `--start-step=verify-jenkins-x-environment` to resume from the failed step

## configure load balancer
```bash
kubectl patch svc jxing-nginx-ingress-controller -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.0.1"]}}' -n kube-system
```

## patches
run following patches to reduce the number of replicas
```bash
 kubectl patch deployments -n kube-system jxing-nginx-ingress-controller \
    -p '{"spec":{"replicas":1}}'

 kubectl patch deployments -n jx deck -p '{"spec":{"replicas":1}}'

 kubectl patch deployments -n jx hook -p '{"spec":{"replicas":1}}'

```

## configure insecure registry
install registry
```bash
kubectl apply -f https://raw.githubusercontent.com/jatikuma29iv/cheatSheets/master/jenkins-x_baremetal/registry.yaml -n jx
```
get cluster ip of service `svc/registry`

`kubectl get service registry`

add `docker.registry` to `configmap/jenkins-x-docker-registry`
```bash
kubectl edit cm jenkins-x-docker-registry
```
add value to yaml as below
```yaml
apiVersion: v1
data:
  docker.registry: 10.110.128.62:5000
```

setup insecure registry in the docker daemon.
In the host server update `/etd/docker/daemon.json` and add
`sudo vim /etc/docker/daemon.json`
```json
{ 

"insecure-registries" : [
    "10.110.128.62:5000",
    "registry:5000"
  ]
}
```

restart docker daemon
`sudo service docker restart`

confirm insecure registry
`docker info`
