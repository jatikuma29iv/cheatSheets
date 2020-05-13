# Jenkins X Overview

Jenkins X is not just a CI/CD tool to run your builds and deployments,
it is an attempt to automate the whole development process end to end for containerised
applications based on Docker and Kubernetes.
It is obviously open source, as all best applications.

## Strengths of Jenkins X:

* Entry level for DevOps/GitOps implementation lowers significantly due to E2E automation of GitOps processes
* Strong concept: [GitOps](https://www.weave.works/blog/gitops-operations-by-pull-request) processes as a foundation of the project
* Good toolset out of the box, which is already configured and works (k8s, [Jenkins](https://jenkins.io/),
[Docker registry](https://docs.docker.com/registry/),
[Chartmuseum](https://github.com/kubernetes-helm/chartmuseum), Monokular, [Nexus](https://github.com/kubernetes-helm/chartmuseum))
* Quickstarts make a creation of new apps an easy ride
* Ability to customise the pipelines and their templates

## The problem
The main problem, which Jenkins X (‘JX’ hereafter) is going to address is formulated by its creators as ‘make it simple for developers to work to DevOps principles and best practices’. Some of that are:
* Frequent deployments
* Low Mean Time to Recover
* CI/CD
* Configuration as Code
* Automated Release Management

In plain English, that means JX takes a challenge to automate a creation of development environments and facilitate development process. So, once JX is installed and set up, it does:
* create a Git repo for a new application
* create a pipeline configuration in Jenkins for a new application and connect it with a Git repo
* automate the DevOps processes (like builds, artefacts and containers creation and publishing, deployments) based on Git operations (branching, commits, PR creating, PR merging)

## Jenkins X Flow
![flow](https://blog.octo.com/wp-content/uploads/2018/04/jxhd-graph-2-1024x611.png)

Git actions. For simplicity, let’s use only master and one feature branch. 
![git flow](https://blog.octo.com/wp-content/uploads/2018/04/jxhd-graph-3-1024x230.png)

The table details the steps of the flow.
![git jx integration](https://blog.octo.com/wp-content/uploads/2018/04/jxhd-graph-4-1024x789.png)

## Table of definitions
<table>
<tbody>
<tr>
<td><b><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">name</span></span></span></span></span></span></b></td>
<td><b><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Description</span></span></span></span></span></span></b></td>
</tr>
<tr>
<td><a href="https://git-scm.com/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Git</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">The most popular VCS</span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="https://jenkins.io/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Jenkins</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">An open source CI / CD automation platform</span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="http://jenkins-x.io/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Jenkins X</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">A subproject of Jenkins, automates CI/CD processes in Kubernetes based systems</span></td>
</tr>
<tr>
<td><a href="https://kubernetes.io/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Kubernetes</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">a.k.a. k8s, open source, distributed management system of containerized applications</span></td>
</tr>
<tr>
<td><a href="https://kubernetes.io/docs/getting-started-guides/minikube/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Minikube</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">A tool to run Kubernetes locally</span></td>
</tr>
<tr>
<td><a href="https://www.weave.works/blog/gitops-operations-by-pull-request"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">GitOps</span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">A set of principles for managing software and infrastructure based on Git</span></td>
</tr>
<tr>
<td><a href="https://www.docker.com/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Docker</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">A containers management platform</span></span></span></span></span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="https://docs.docker.com/registry/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Docker registry</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">A repository to store and distribute Docker containers</span></td>
</tr>
<tr>
<td><a href="https://www.sonatype.com/nexus-repository-oss"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Nexus</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">An artifact repository</span></span></span></span></span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="https://helm.sh/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Helm</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">A package manager for Kubernetes</span></span></span></span></span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="https://docs.helm.sh/developing_charts/#charts"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Helm Chart</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">A collection of configuration files that describe a related set of Kubernetes resources. E.g. chart, describing an application stack</span></td>
</tr>
<tr>
<td><a href="https://github.com/kubernetes-helm/chartmuseum"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Chartmuseum</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">An open-source Helm Chart Repository</span></span></span></span></span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="https://github.com/kubernetes-helm/monocular"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Monocular</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">An open-source web-based UI for Helm Chart management</span></span></span></span></span></span></span></span></span></span></span></td>
</tr>
<tr>
<td><a href="http://jenkins-x.io/developing/create-quickstart/"><span style="font-weight: 400;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;"><span style="vertical-align: inherit;">Quickstart</span></span></span></span></span></span></span></span></span></span></span></a></td>
<td><span style="font-weight: 400;">Pre-made Jenkins X applications templates a developer can start a project from, instead of starting from scratch</span></td>
</tr>
</tbody>
</table>

## refs:
1. [JenkinsX – new Kubernetes dream? Part 1](https://blog.octo.com/en/jenkinsx-new-kubernetes-dream-part-1/)
