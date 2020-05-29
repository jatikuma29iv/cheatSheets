# TOC
## CI/CD
### jx
## kubernetes cmds
## NoOps Recipe
## GCP/GKE
## IBM
## microk8s
## minikube
## minishift (Openshift 3.11)
## Component Setup
### docker registry/local registry
#### Installation on `minikube`
### Gitlab
### istio
### Jenkins
## Development

# CI/CD
## jx
Tools:
1. kubernetes
2. jx (jenkins x)
3. helm charts
4. istio
5. grafana
6. flagger](https://docs.flagger.app/usage/how-it-works)

**CI/CD**
7. Jenkins
8. Tekton (open source google)

### Build

### Release

### Scale

### Circuit Break

### Monitor


# kubernetes cmd

## exec
```bash
kubectl exec -ti jenkins-x-nexus-XXXXXXX -- sh
cat > /usr/local/bin/curl <<__EOF__
#!/bin/sh
exec /usr/bin/curl -4 $@
__EOF__
chmod +x  /usr/local/bin/curl
```

# GCP/GKE

## Create Cluster

 ```bash
 # Regional cluster (single cluster in a single region)
 # autoscalable to 6
 gcloud container clusters create gke-c04 \
    --num-nodes 1 --machine-type n1-standard-2 \
    --region asia-southeast1 --node-locations asia-southeast1-b \
    --preemptible \
    --enable-autoscaling \
    --min-nodes 1 --max-nodes 6

 # This creates 1 node in each region of the zone
 # in total 3 nodes autoscalable to 4
 gcloud beta container clusters create ray-gke-cluster01 \
    --num-nodes 1 --machine-type g1-small \
    --zone asia-southeast1 \
    --cluster-version latest \
    --enable-autoscaling \
    --min-nodes 1 --max-nodes 4
    
 # Single zone cluster
 # Below command give 1 node per region of the zone which equals to 3 nodes
```bash
gcloud container clusters create cluster-name \
    --zone compute-zone \
    --cluster-version version
 ```
 
Ref:
  https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster
  Cost cutting with  autoscaling Preemptible VMs
[Cutting costs with Google Kubernetes Engine: using the cluster autoscaler and Preemptible VMs](https://cloud.google.com/blog/products/containers-kubernetes/cutting-costs-with-google-kubernetes-engine-using-the-cluster-autoscaler-and-preemptible-vms)

## connect
```bash
gcloud container clusters get-credentials gke-c03 \
  --region asia-southeast1 --project tough-chassis-272102
```

## set default zone
```bash
gcloud config set compute/zone asia-southeast1-b
```

## Stop Cluster
```bash
gcloud container clusters resize gke-c03 --num-nodes=0
```

# IBM

[Building a DevOps Teaching Classroom environment for IBM – Part I](https://medium.com/faun/building-a-devops-teaching-classroom-environment-for-ibm-part-i-78104c564250)

pte (pearson test of english)
expat 
http://agile-solutions.ch/jenkins-x/

https://github.com/kubernetes/minikube/blob/master/CHANGELOG.md

https://www.youtube.com/watch?v=BF3MhFjvBTU


# microk8s

[Alternative install methods](https://microk8s.io/docs/install-alternatives#macos)
[An overview of MicroK8s (a tool to quick-start a Kubernetes cluster) and why using it in the cloud was a terrible idea](https://medium.com/faun/an-overview-of-microk8s-and-why-using-it-in-the-cloud-was-a-terrible-idea-9ba8506dc467)

[microk8s-jenkins-x-setup](https://github.com/lklacar/microk8s-jenkins-x-setup)

# minikube
## Installation
### Install Virtual Box (dependency)
Download and install the [latest version of VirtualBox](https://www.virtualbox.org/wiki/Downloads) for your operating system. VirtualBox lets Minikube run a Kubernetes node on a virtual machine (VM)

### Install Homebrew (dependency)
Follow instructions [here](https://treehouse.github.io/installation-guides/mac/homebrew)

### Install tools (dependency)
```bash
brew install minikube kubectl helm skaffold
# specific version installation below
```

To specific version of `minikube`
```bash
curl -Lo minikube-1.0.1 https://storage.googleapis.com/minikube/releases/v1.0.1/minikube-darwin-amd64 \
  && chmod +x minikube-1.0.1 \
  && sudo ln -Fs `pwd`/minikube-1.0.1 /usr/local/bin/minikube
```
### Create Cluster & Start minikube
```bash
minikube start --vm-driver=virtualbox --memory 8192 --cpus=4
```

### Enable addons
```bash
minikube addons enable ingress
```

### Enable dashboard

`minikube dashboard`

# minishift (Openshift 3.11)

## How to resolve `gitlab.ray.com`

Find `minishift` ip by running command `minishift ip` on the host.

Seems `minishift` vm created a network `192.168.64.x`. Find host ip created by `minishift` by running command `ifconfig | grep 192` on host

Take the `minishit's` host ip and add it to `minishift` vm's `/etc/hosts`. ssh into minishift vm and edit 

## Red Hat OpenShift 4 on your laptop
[https://haralduebele.blog/2019/09/13/red-hat-openshift-4-on-your-laptop/](https://haralduebele.blog/2019/09/13/red-hat-openshift-4-on-your-laptop/)


# Component Setup
## docker registry/local registry

Set up the cluster registry by applying a .yaml manifest file.

```bash
kubectl apply -f manifests/registry.yaml
```

Wait for the registry to finish deploying using the following command. Note that this may take several minutes.

`kubectl rollout status deployments/registry`

View the registry user interface in a web browser.

`minikube service registry-ui`

### Installation on `minikube`
deploy `docker` image `registry:2` on `k8s`

deployment yaml `registry.yaml`
```yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: registry
  labels:
    type: local
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data/registry/"

---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: registry-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi
---

apiVersion: v1
kind: Service
metadata:
  name: registry
  labels:
    app: registry
spec:
  ports:
    - port: 5000
      targetPort: 5000
      nodePort: 30400
      name: registry
  selector:
    app: registry
    tier: registry
  type: NodePort
---

apiVersion: v1
kind: Service
metadata:
  name: registry-ui
  labels:
    app: registry
spec:
  ports:
    - port: 8080
      targetPort: 8080
      name: registry
  selector:
    app: registry
    tier: registry
  type: NodePort
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: registry
  labels:
    app: registry
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: registry
  template:
    metadata:
      labels:
        app: registry
        tier: registry
    spec:
      containers:
      - image: registry:2
        name: registry
        volumeMounts:
        - name: docker
          mountPath: /var/run/docker.sock
        - name: registry-persistent-storage
          mountPath: /var/lib/registry
        ports:
        - containerPort: 5000
          name: registry
      - name: registryui
        image: hyper/docker-registry-web:latest
        ports:
        - containerPort: 8080
        env:
        - name: REGISTRY_URL
          value: http://localhost:5000/v2
        - name: REGISTRY_NAME
          value: cluster-registry
      volumes:
      - name: docker
        hostPath:
          path: /var/run/docker.sock
      - name: registry-persistent-storage
        persistentVolumeClaim:
          claimName: registry-claim
```

Set up the cluster registry by applying a .yaml manifest file.

`kubectl apply -f registry.yaml`

Wait for the registry to finish deploying using the following command. Note that this may take several minutes.

`kubectl rollout status deployments/registry`

View the registry user interface in a web browser.

`minikube service registry-ui`

#### Testing the registry

clone the repo `https://github.com/kenzanlabs/kubernetes-ci-cd.git`

##### Step 1
Now let’s build an image, giving it a special name that points to our local cluster registry.

`docker build -t 127.0.0.1:30400/hello-kenzan:latest -f applications/hello-kenzan/Dockerfile applications/hello-kenzan`

##### Step 2

We’ve built the image, but before we can push it to the registry, we need to set up a temporary proxy. By default the Docker client can only push to HTTP (not HTTPS) via localhost. To work around this, we’ll set up a Docker container that listens on 127.0.0.1:30400 and forwards to our cluster. First, build the image for our proxy container.

`docker build -t socat-registry -f applications/socat/Dockerfile applications/socat`

##### Step 3

Now run the proxy container from the newly created image. (Note that you may see some errors; this is normal as the commands are first making sure there are no previous instances running.)

``docker stop socat-registry; docker rm socat-registry; docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400" --name socat-registry -p 30400:5000 socat-registry``

##### Step 4

With our proxy container up and running, we can now push our hello-kenzan image to the local repository.

`docker push 127.0.0.1:30400/hello-kenzan:latest`

##### Step 5

The proxy’s work is done, so you can go ahead and stop it.

`docker stop socat-registry`

##### Step 6

With the image in our cluster registry, the last thing to do is apply the manifest to create and deploy the hello-kenzan pod based on the image.

`kubectl apply -f applications/hello-kenzan/k8s/manual-deployment.yaml`

##### Step 7

Launch a web browser and view the service.

`minikube service hello-kenzan`

##### Step 8

Delete the hello-kenzan deployment and service you created. We are going to keep the registry deployment in our cluster as we will need it for the next few parts in our series.

`kubectl delete service hello-kenzan`

`kubectl delete deployment hello-kenzan`


## Gitlab

ref: [https://docs.gitlab.com/omnibus/docker/](https://docs.gitlab.com/omnibus/docker/)
### Setup
```bash
sudo docker run --detach  \
  --hostname gitlab.ray.com \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.ray.com/'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 2289;"  \
  --publish 443:443 --publish 80:80 --publish 2289:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
 gitlab/gitlab-ce:latest
```

Update /etc/hosts to resolve `gitlab.ray.com`
```
127.0.0.1 gitlab.ray.com
```


## istio  
[https://itnext.io/jenkins-x-istio-flagger-canary-deployment-9d5e187c2334](https://itnext.io/jenkins-x-istio-flagger-canary-deployment-9d5e187c2334)


## Jenkins

**\*\*Note:\*\*** This is a manual installation hence I'm keeping on hold
 
 **Ref:**
 [Set Up a CI/CD Pipeline with Kubernetes Part 1: Overview](https://www.linux.com/blog/learn/chapter/Intro-to-Kubernetes/2017/5/set-cicd-pipeline-kubernetes-part-1-overview)
 [Set Up A CI/CD Pipeline With A Jenkins Pod In Kubernetes (Part 2)](https://www.linux.com/audience/devops/set-cicd-pipeline-jenkins-pod-kubernetes-part-2/)
[How To Setup Jenkins On Kubernetes Cluster – Beginners Guide](https://devopscube.com/setup-jenkins-on-kubernetes-cluster/)

**Step 1** Let's build the Jenkins Docker image we'll use in our Kubernetes cluster.
```bash
docker build -t 127.0.0.1:30400/jenkins:latest -f applications/jenkins/Dockerfile applications/jenkins
```

**Step 2** We'll need to set up the Socat Registry proxy container to push images, so let's build it. 
```bash
docker build -t socat-registry -f applications/socat/Dockerfile applications/socat
```

**Step 3** Run the proxy container from the image.
```bash
docker stop socat-registry; docker rm socat-registry; docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400" --name socat-registry -p 30400:5000 socat-registry; sleep 10
```

**Step 4** With our proxy container up and running, we can now push our Jenkins image to the local repository.
```bash
docker push 127.0.0.1:30400/jenkins:latest
```

**Step 5** The proxy’s work is done, so you can go ahead and stop it.
```bash
docker stop socat-registry
```

**Step 6** Deploy Jenkins, which we’ll use to create our automated CI/CD pipeline. It will take the pod a minute or two to roll out.
```bash
kubectl apply -f manifests/jenkins.yaml; kubectl rollout status deployment/jenkins
```

**Step 7** Open the Jenkins UI in a web browser.
```bash
minikube service jenkins
```

**Step 8** Get jenkins password
```bash
kubectl exec -it `kubectl get pods --selector=app=jenkins --output=jsonpath={.items..metadata.name}` \
  cat /var/jenkins_home/secrets/initialAdminPassword
```
Switch back to the Jenkins UI. Paste the Jenkins admin password in the box and click Continue. Click Install suggested plugins. Plugins have actually been pre-downloaded during the Jenkins image build, so this step should finish fairly quickly.

**Step 9**
Create an admin user and credentials, and click Save and Continue. (Make sure to remember these credentials as you will need them for repeated logins.) On the Instance Configuration page, click Save and Finish. On the next page, click Restart (if it appears to hang for some time on restarting, you may have to refresh the browser window). Login to Jenkins.

`admin/admin@123`

** Step 10**
Before we create a pipeline, we first need to provision the Kubernetes Continuous Deploy plugin with a kubeconfig file that will allow access to our Kubernetes cluster. In Jenkins on the left, click on Credentials, select the Jenkins store, then Global credentials (unrestricted), and Add Credentials on the left menu.

# Development
## nodejs dev
[How to debug a Node.js application deployed with Jenkins X](https://www.rookout.com/blog/how-to-debug-a-node-js-application-deployed-with-jenkins-x)

#### Hot deploy
[Developing on Kubernetes](https://kubernetes.io/blog/2018/05/01/developing-on-kubernetes/)
[The ultimate guide for local development on Kubernetes: Draft vs Skaffold vs Garden.io](https://codefresh.io/howtos/local-k8s-draft-skaffold-garden/)

## Blue/Green testing
## Canary Testing
[Jenkins-X Istio Flagger Canary Deployment](https://itnext.io/jenkins-x-istio-flagger-canary-deployment-9d5e187c2334)

## Ops
### Pre-requisites
### Registry
### CI/CD


## Notes



## What are we trying to solve

- Developer template
	- docker
	- openshift
	- React/ng/AspNetCore/Java
- Reusable components
	- React/ng/AspNetCore
- AuthN/AuthR/Security
- Environment parameters in code/Lack of duplicatable deployment configuration
- Quick spinning of new Environment

Writers don't write for views or comments, they do if for the passion of sharing/teaching

> Written with [StackEdit](https://stackedit.io/).



# docker registry (local registry)



# CONCEPTPS

## Configuration as code

# GKE Installation

## installing jx

```bash
# create gke cluster
gcloud container clusters create gke-c06 \
   --num-nodes 1 --machine-type n1-standard-2 \
   --region asia-southeast1 --node-locations asia-southeast1-b \
   --preemptible \
   --enable-autoscaling \
   --min-nodes 1 --max-nodes 4

# install jx
jx install --default-admin-password="admin123" \
--git-username=jenkins-x-bot --username="craft.de.jet@gmail.com" \
--git-api-token=a87a477c8b1c9059003a03a0a021899a858f70ba \
--default-environment-prefix="gke-c06" \
--external-ip=35.240.189.194 --provider gke

jx install --provider gke --ingress-service=istio-ingressgateway \
--ingress-deployment=istio-ingressgateway \
--ingress-namespace=istio-system \
--ingress-service=istio-ingressgateway \
--ingress-deployment=istio-ingressgateway \
--git-username=jenkins-x-bot --git-api-token=a87a477c8b1c9059003a03a0a021899a858f70ba \
--default-environment-prefix="gke-c05" --default-admin-password="admin123" \
--external-ip=34.87.74.167 --username="craft.de.jet@gmail.com"
```

$ jx install gke --ingress-service=istio-ingressgateway --ingress-deployment=istio-ingressgateway --ingress-namespace=istio-system
Command "install" is deprecated, it will be removed on Jun 1 2020. We now highly recommend you use jx boot instead. Please check https://jenkins-x.io/docs/getting-started/setup/boot/ for more details.
WARNING

Traditional Jenkins masters are being deprecated and removed from all new Jenkins X releases starting on April 20, 2020.
We strongly recommend using the default Tekton-based configuration instead for all Jenkins X activity going forward. We do not recommend using the Jenkins X workflow based around Jenkins masters.

For more information: https://jenkins-x.io/blog/2020/03/11/tekton/
? Select Jenkins installation type: Serverless Jenkins X Pipelines with Tekton
Context "gke_tough-chassis-272102_asia-southeast1_ray-gke-cluster02" modified.
? Cloud Provider gke
Git configured for user: Jet and email craft-de-jet@gmail.com
Helm installed and configured
existing ingress controller found, no need to install a new one
Note: this loadbalancer will fail to be provisioned if you have insufficient quotas, this can happen easily on a GKE free account.
To view quotas run: gcloud compute project-info describe
Waiting for external loadbalancer to be created and update the nginx-ingress-controller service in istio-system namespace
External loadbalancer created
Waiting to find the external host name of the ingress controller Service in namespace istio-system with name istio-ingressgateway
You can now configure a wildcard DNS pointing to the new Load Balancer address 34.87.141.97
If you don't have a wildcard DNS setup then create a DNS (A) record and point it at: 34.87.141.97, then use the DNS domain in the next input...

If you do not have a custom domain setup yet, Ingress rules will be set for magic DNS nip.io.
Once you have a custom domain ready, you can update with the command jx upgrade ingress --cluster
? Domain 34.87.141.97.nip.io
nginx ingress controller installed and configured
? Default enabling long term logs storage: Yes
? Google Cloud Zone: asia-southeast1-b
No bucket name provided for long term storage, creating a new one
The bucket gs://ray-gke-cluster02-lts-36062c98-708e-454b-b144-5dc19331119d does not exist so lets create it
Set up a Git username and API token to be able to perform CI/CD
? Do you wish to use jenkins-x-bot as the local Git user for github.com server: Yes
Select the CI/CD pipelines Git server and user
? Do you wish to use github.com as the pipelines Git server: Yes
Setting the pipelines Git server https://github.com and user name jenkins-x-bot.
? A local Jenkins X cloud environments repository already exists, recreating with latest: Yes
Enumerating objects: 1440, done.
Total 1440 (delta 0), reused 0 (delta 0), pack-reused 1440
Updating Secret jx-install-config in namespace jx
Setting up prow config into namespace jx
Installing Tekton into namespace jx

Installing Prow into namespace jx
with values file /Users/jatikuma29iv/.jx/cloud-environments/env-gke/myvalues.yaml

? Defaulting workload build pack: Kubernetes Workloads: Automated CI+CD with GitOps Promotion
Setting the team build pack to kubernetes-workloads repo: https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes.git ref: master
Installing jx into namespace jx
Installing jenkins-x-platform version: 2.0.2096

WARNING: waiting for install to be ready, if this is the first time then it will take a while to download images
WARNING: deployment jenkins-x-heapster failed to become ready in namespace jx
Jenkins X deployments ready in namespace jx
Configuring the TeamSettings for ImportMode YAML
Creating default staging and production environments
? Select the organization where you want to create the environment repository:  [Use arrows to move, sp? Select the organization where you want to create the environment repository: jenkins-x-bot
Using Git provider github.com at https://github.com
? Using Git user name: jenkins-x-bot
? Using organisation: jenkins-x-bot
Creating repository jenkins-x-bot/environment-flyholy-staging
Creating Git repository jenkins-x-bot/environment-flyholy-staging
Pushed Git repository to https://github.com/jatikuma29iv/environment-flyholy-staging

Updating staging Environment in namespace jx
Created environment staging
Creating GitHub webhook for jatikuma29iv/environment-flyholy-staging for url http://hook.jx.34.87.141.97.nip.io/hook
Using Git provider github.com at https://github.com
? Using Git user name: jenkins-x-bot
? Using organisation: jenkins-x-bot
Creating repository jenkins-x-bot/environment-flyholy-production
Creating Git repository jenkins-x-bot/environment-flyholy-production
Pushed Git repository to https://github.com/jatikuma29iv/environment-flyholy-production

Updating production Environment in namespace jx
Created environment production
Creating GitHub webhook for jatikuma29iv/environment-flyholy-production for url http://hook.jx.34.87.141.97.nip.io/hook

Jenkins X installation completed successfully


        ********************************************************

             NOTE: Your admin password is: dIzL97IlLI_auoia,1x1

        ********************************************************


Your Kubernetes context is now set to the namespace: jx
To switch back to your original namespace use: jx namespace jx
Or to use this context/namespace in just one terminal use: jx shell
For help on switching contexts see: https://jenkins-x.io/developing/kube-context/
To import existing projects into Jenkins X:       jx import
To create a new Spring Boot microservice:       jx create spring -d web -d actuator
To create a new microservice from a quickstart: jx create quickstart
```bash
$ helm repo list
NAME                                            URL
stable                                          https://kubernetes-charts.storage.googleapis.com
local                                           http://127.0.0.1:8879/charts
jenkins-x                                       https://storage.googleapis.com/chartmuseum.jenkins-x.io
chartmuseum.cicd-system.192.168.99.106.nip.io   http://chartmuseum.cicd-system.192.168.99.106.nip.io
```

## Jx react app
$ jx create quickstart
? select the quickstart you wish to create react-quickstart
Using Git provider github.com at https://github.com
? Do you wish to use jatikuma29iv as the Git user name? Yes
? Who should be the owner of the repository? jatikuma29iv
? Enter the new repository name:  react-qs-jx-gke
Creating repository jatikuma29iv/react-qs-jx-gke
Generated quickstart at /Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke
Created project at /Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke
The directory /Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke is not yet using git
? Would you like to initialise git now? Yes
? Commit message:  Initial import

Git repository created
performing pack detection in folder /Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke
--> Draft detected Easybuild (89.520066%)
--> Could not find a pack for Easybuild. Trying to find the next likely language match...
--> Draft detected SVG (9.435850%)
--> Could not find a pack for SVG. Trying to find the next likely language match...
--> Draft detected HTML (0.570283%)
--> Could not find a pack for HTML. Trying to find the next likely language match...
--> Draft detected JSON (0.222374%)
--> Could not find a pack for JSON. Trying to find the next likely language match...
--> Draft detected CSS (0.159249%)
--> Could not find a pack for CSS. Trying to find the next likely language match...
--> Draft detected JavaScript (0.088950%)
selected pack: /Users/jatikuma29iv/.jx/draft/packs/github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/packs/javascript
replacing placeholders in directory /Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke
app name: react-qs-jx-gke, git server: github.com, org: jatikuma29iv, Docker registry org: jatikuma29iv
skipping directory "/Users/jatikuma29iv/work/jenkin-x/react-qs-jx-gke/.git"
Pushed Git repository to https://github.com/jatikuma29iv/react-qs-jx-gke
Automatically adding the pipeline user: jenkins-x-bot as a collaborator.
WARNING: Pipeline Git user credentials not found. jenkins-x-bot will need to accept the invitation to collaborateon react-qs-jx-gke if jenkins-x-bot is not part of jatikuma29iv.
Creating GitHub webhook for jatikuma29iv/react-qs-jx-gke for url http://hook.jx.34.87.141.97.nip.io/hook

Watch pipeline activity via:    jx get activity -f react-qs-jx-gke -w
Browse the pipeline log via:    jx get build logs jatikuma29iv/react-qs-jx-gke/master
You can list the pipelines via: jx get pipelines
When the pipeline is complete:  jx get applications

For more help on available commands see: https://jenkins-x.io/developing/browsing/

Note that your first pipeline may take a few minutes to start while the necessary images get downloaded!

## Activity
```bash
jatikuma29iv/react-qs-jx-gke/master #1                           1m55s          Running
  meta pipeline                                                  1m55s          Running
    Credential Initializer K9kpp                                 1m55s       0s Succeeded
    Working Dir Initializer Wqgr7                                1m55s       3s Succeeded
    Place Tools                                                  1m52s       4s Succeeded
    Git Source Meta Jatikuma29iv React Qs Jx G Pcd88 Cdhfs       1m48s    1m45s Succeeded https://github.com/jatikuma29iv/react-qs-jx-gke.git
    Git Merge                                                       3s       1s Succeeded
    Merge Pull Refs                                                 2s       1s Succeeded
    Create Effective Pipeline                                       1s          Running
    Create Tekton Crds                                                          Pending
jatikuma29iv/react-qs-jx-gke/master #1                           2m10s     2m3s Failed
  meta pipeline                                                  2m10s     2m3s Failed
    Credential Initializer K9kpp                                 2m10s       0s Succeeded
    Working Dir Initializer Wqgr7                                2m10s       3s Succeeded
    Place Tools                                                   2m7s       4s Succeeded
    Git Source Meta Jatikuma29iv React Qs Jx G Pcd88 Cdhfs        2m3s    1m45s Succeeded https://github.com/jatikuma29iv/react-qs-jx-gke.git
    Git Merge                                                      18s       1s Succeeded
    Merge Pull Refs                                                17s       1s Succeeded
    Create Effective Pipeline                                      16s       9s Failed
    Create Tekton Crds                                              7s       0s NotExecute
```

# Trouble shooting

Get http://127.0.0.1:8879/charts/index.yaml: dial tcp 127.0.0.1:8879: connect: connection refused

### Solution
**Open `git` repo of `production` env**
1. switch to `jx` namespace
  `jx ns jx`
  assuming `jenkins X` is installed in namespace `jx`
1. switch to `dev` env
  `jx env dev`
1. run cmd `jx get env`
Click on `production` env `url` to open `git` repo eg. https://github.com/<user>/environment-<your_env_name>-production.git

**Remove following lines from the file `env/requirements.yaml`**
In the `git` repo of `production` open file `env/requirements.yaml` and delete following lines
```yaml
- name: env
  repository: http://jenkins-x-chartmuseum:8080
  version: x.x.x
```

**Now execute promote cmd again**
1. Go to cmd line and change to root folder of you source code
  `cd /path/of/you/source/code`
2. switch to `jx` namespace
  `jx ns jx`
  assuming `jenkins X` is installed in namespace `jx`
3. switch to `dev` env
  `jx env dev`
4. run promote cmd (replace `0.0.2` with your version)
  `jx promote --version 0.0.2 --env production`
  answer questions and approve newly created `Pull request` on `production` `git` repo
5. check activity logs
  `jx get build logs`
6. you can also activity logs (replace <your_app_name> with name of ur `app`)
  `jx get activity -f <your_app_name> -w`
  select the first filter, should be ending with `#xx production`

Promotion to production should succeed.

### Reason
If cmd `jx promote --version 0.0.2 --env production` is executed from folder of source `git` folder, `Jenkins X` does a `env promote` instead of `app promote`
This adds following config in the `env/requirements.yaml`, setting env version to the `--version x.x.x` provided
```yaml
- name: env
  repository: http://jenkins-x-chartmuseum:8080
  version: 0.0.2
```
after this promotions keeps failing.

Execute promote cmd from within the source root folder.

# k3s on vagrant alpin

## Install vagrant
download installer from site

execute command `vagrant plugin install vagrant-disksize vagrant-reload`

`vagrant-disksize` for enabling disk size

## Vagrantfile
```
$script_alpine_setup = <<-SCRIPT
sudo apk update
sudo apk add curl sed
grep 'default_kernel_opts="cgroup_enable' /etc/update-extlinux.conf || \
  sudo sed \
    -i 's/default_kernel_opts="/default_kernel_opts="cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory /' \
    /etc/update-extlinux.conf && \
  sudo update-extlinux && \
  echo "updated /etc/updated-extlinux.conf"
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.box = "alpine/alpine64"

  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

# master node configuration
  config.vm.define "master", primary: true do |c|

    c.disksize.size = '200GB'

    c.vm.hostname = "kubemaster"

    c.vm.network "private_network", ip: "192.168.33.10"

    #c.vm.network "forwarded_port", guest: 6443, host: 6443, host_ip: "127.0.0.1"

    c.vm.provider "virtualbox" do |v|
      v.name = "k3s-master-alpine"
      v.memory = 2048
    end

    c.vm.provision "shell", inline: $script_alpine_setup

    c.vm.provision :reload

    c.vm.provision "shell", inline: <<-SHELL
      mkdir -p /vagrant/.kube
      sudo bash
      curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 K3S_NODE_NAME="master" INSTALL_K3S_EXEC="server --tls-san 192.168.33.10 --advertise-address 192.168.33.10" sh - \
      && sleep 10 \
      && cp /etc/rancher/k3s/k3s.yaml /vagrant/.kube/config \
      && cp /var/lib/rancher/k3s/server/node-token /vagrant/.kube/ \
      && sed -i 's|server:.*|server: https:\/\/192.168.33.10:6443|g' /vagrant/.kube/config
    SHELL

# to enable login as root
# comment to creat defaut vagrant user
    #master.ssh.username = 'root'

  end

# worker node1 configuration
  config.vm.define "node1", autostart: true do |c|

    c.vm.hostname = "agent-01"

    c.vm.network "private_network", ip: "192.168.33.11"

    c.vm.provider "virtualbox" do |v|
      v.name = "k3s-node1-alpine"
      v.memory = 2048
    end

    c.vm.provision "shell", inline: $script_alpine_setup

    c.vm.provision :reload

    c.vm.provision "shell", inline: <<-SHELL
      sudo bash
      curl -sfL https://get.k3s.io | K3S_URL=https://192.168.33.10:6443 K3S_TOKEN=`cat /vagrant/.kube/node-token` K3S_NODE_NAME="agent-01" INSTALL_K3S_VERSION=v0.9.1 sh -
    SHELL

# to enable login as root
# comment to creat defaut vagrant user
    #c.ssh.username = 'root'

  end

# worker node2 configuration
  config.vm.define "node2", autostart: false do |c|

    c.vm.hostname = "agent-02"

    c.vm.network "private_network", ip: "192.168.33.12"

    c.vm.provider "virtualbox" do |v|
      v.name = "k3s-node2-alpine"
      v.memory = 2048
    end

# to enable login as root
# comment to creat defaut vagrant user
    #node2.ssh.username = 'root'

  end

# worker node3 configuration
  config.vm.define "node3", autostart: false do |c|

    c.vm.hostname = "agent-03"

    c.vm.network "private_network", ip: "192.168.33.13"

    c.vm.provider "virtualbox" do |v|
      v.name = "k3s-node3-alpine"
      v.memory = 2048
    end

# to enable login as root
# comment to creat defaut vagrant user
    #node2.ssh.username = 'root'

  end

# worker node4 configuration
  config.vm.define "node4", autostart: false do |c|

    c.vm.hostname = "agent-04"

    c.vm.network "private_network", ip: "192.168.33.14"

    c.vm.provider "virtualbox" do |v|
      v.name = "k3s-node4-alpine"
      v.memory = 2048
    end

    c.vm.provision "shell", inline: <<-SHELL
      sudo bash
      sed -i 's|server:.*|server: https:\/\/192.168.33.10|g' /vagrant/.kube/config
    SHELL

# to enable login as root
# comment to creat defaut vagrant user
    #node2.ssh.username = 'root'

  end
end
```

## generate token
```
https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo
```

## add storage
1. Create directory that’s needed by local provisioner:  `sudo mkdir /opt/local-path-provisioner`
2.  Install local provisioner:  
	```bash
	kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
	```
3.  Set the local provisioner as default: 
	```bash
	kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
	```

## jx install
```bash
export iJX_IP=192.168.33.10
jx install --provider=kubernetes --external-ip=$iJX_IP \
--ingress-service=traefik \
--ingress-deployment=traefik \
--ingress-namespace=kube-system \
--on-premise \
--domain=$iJX_IP.nip.io \
--default-admin-password="admin123" \
--git-username="craft.de.jet@gmail.com" --username="craft.de.jet@gmail.com" \
--default-environment-prefix="k3s-alpine" \
--git-api-token=c75ca4b918f262d9c3f84dc9f154628c52851633

kubectl patch deployments hook -p '{"spec":{"replicas":1}}' -n jx
kubectl patch deployments deck -p '{"spec":{"replicas":1}}' -n jx

pipeline token 2569a2c17b1cd5a9da95665bb66d5df1618a6020

```

https://rancher.com/docs/k3s/latest/en/installation/private-registry/

# nfigmap 'jenkins-x-docker-registry' not set when using internal docker registry
https://github.com/jenkins-x/jx/issues/7029

```
kubectl edit cm jenkins-x-docker-registry -n jx

docker.registry: 10.0.45.198:5000 # Add the service address and port of the jenkins-x-docker-registry service
k
```

```
        [plugins.cri.registry.mirrors."10.141.241.175:32000"]
          endpoint = ["http://10.141.241.175:32000"]
```

https://microk8s.io/docs/registry-private

## Setup k3s-master VM on vagrant and alpine

run `vagrant init alpine/alpine64`. This will create `Vagrantfile`. Update `Vagrantfile` with following lines:
```
config.disksize.size = '200GB'

config.vm.provider "virtualbox" do |v|
  v.name = "k3s-master"
  v.memory = 4096
  v.cpus = 2
end
```

## Enable root login over SSH:

1.  As root, edit the sshd_config file in  `/etc/ssh/sshd_config`:
    ```
    vi /etc/ssh/sshd_config
    ```
    
2.  Add a line in the Authentication section of the file that says  _`PermitRootLogin yes`_. This line may already exist and be commented out with a "#". In this case, remove the "#".
    ```
    # Authentication:
    #LoginGraceTime 2m
    PermitRootLogin yes
    #StrictModes yes
    #MaxAuthTries 6
    #MaxSessions 10
    ```
3.  Save the updated  `/etc/ssh/sshd_config`  file.
    
4.  Restart the SSH server:
    ```
    service sshd restart
    ```
5. copy `.ssh` key to `root` to enable passwd less entry
    ```
    sudo cp -r ~/.ssh /root/
    ```
6. halt vm, update `Vagrantfile` and add
    ```
    # to enable login as root
    # comment to creat defaut vagrant user
    config.ssh.username = 'root'
    ```
    and restart vm
    
You can now connect to the conversion server as root over SSH.

## change root passwd
`sudo passwd root`

## Addition
Update  **/etc/update-extlinux.conf**  by adding:

```
default_kernel_opts="...  cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"
```

Then update the config and reboot:
```bash
update-extlinux
reboot
```



## install curl

`apk add curl`

## install k3s

### master
`curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 K3S_NODE_NAME="master" INSTALL_K3S_EXEC="server --tls-san 192.168.44.10 --advertise-address 192.168.44.10 --no-deploy traefik --no-deploy servicelb" sh -`

### agent
`curl -sfL https://get.k3s.io | K3S_URL=https://192.168.44.10:6443 K3S_TOKEN=K1081813b500d56fd960a2ed91291479d36add6d3ec4c45566822d493c526310dbc::node:8f793df5faa8f922d1e77fd816c64b46 K3S_NODE_NAME="agent-01" INSTALL_K3S_VERSION=v0.9.1 sh -`

### add storage

### ingress <pending>
`kubectl patch svc jxing-nginx-ingress-controller -p '{"spec": {"type": "LoadBalancer", "externalIPs":["192.168.44.10"]}}' -n kube-system`

https://stackoverflow.com/questions/52899227/alpine-add-package-from-edge-repository


# Squid cache
## install
```
brew install squid

==> Downloading https://homebrew.bintray.com/bottles/squid-4.10.high_sierra.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/a9/a920686eea11ddb1d3f7fa2ac6a3cd12900e1f5eb181a3f920673e4076f60370?__gda__=exp=1587128162~hmac=832daa3fa9094d1f50908c1a31a150b
######################################################################## 100.0%
==> Pouring squid-4.10.high_sierra.bottle.tar.gz
==> Caveats
To have launchd start squid now and restart at login:
  brew services start squid
Or, if you don't want/need a background service you can just run:
  squid
==> Summary
🍺  /usr/local/Cellar/squid/4.10: 2,111 files, 10.0MB
```

## start
```bash
brew services start squid
```

# Other Flavours

## Terraform

by `Hashicorp` creators of `Vagrant`

[Deploy a Kubernetes Cluster using Terraform and RKE Provider](https://medium.com/@brotandgames/deploy-a-kubernetes-cluster-using-terraform-and-rke-provider-68112463e49d)


# Docker Registry

[Setup a private registry on K3s](https://itnext.io/@zhimin.wen?source=post_page-----f30404f8e4d3----------------------)

[`k3s` Private Registry Configuration](https://rancher.com/docs/k3s/latest/en/installation/private-registry/)



# Vagrant

## Plugins
[Vagrant Provision Reboot Plugin](https://github.com/exratione/vagrant-provision-reboot)



# facebook

[https://www.facebook.com/yogesh.upreti.564?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/yogesh.upreti.564?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/paritosh.sharma.7524?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/paritosh.sharma.7524?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/prem.s.mehta.71?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/prem.s.mehta.71?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/amit.sinha.90857?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/amit.sinha.90857?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/kshitij.sharma.9066/friends?lst=656549355%3A100002695837051%3A1587281421&source_ref=pb_friends_tl](https://www.facebook.com/kshitij.sharma.9066/friends?lst=656549355%3A100002695837051%3A1587281421&source_ref=pb_friends_tl)

[https://www.facebook.com/ashish.k.gupta.568?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/ashish.k.gupta.568?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/nishit.narayan?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/nishit.narayan?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/profile.php?id=588102624&fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/profile.php?id=588102624&fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/ravi.mclean?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/ravi.mclean?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/pragyanam?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/pragyanam?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/swapnilchaturvedi.lko?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/swapnilchaturvedi.lko?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/email.amitgupta/friends?lst=656549355%3A731177186%3A1587281878&source_ref=pb_friends_tl](https://www.facebook.com/email.amitgupta/friends?lst=656549355%3A731177186%3A1587281878&source_ref=pb_friends_tl)

[https://www.facebook.com/vivek.nair.7370013?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/vivek.nair.7370013?fref=profile_friend_list&hc_location=friends_tab)

[https://www.facebook.com/dinesh.yadav.79219?fref=profile_friend_list&hc_location=friends_tab](https://www.facebook.com/dinesh.yadav.79219?fref=profile_friend_list&hc_location=friends_tab)

