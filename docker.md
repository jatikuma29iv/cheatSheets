# Docker

## Docker Hub
```bash
# login to docker hub
$ docker login --username=jatintechjini --email=jatin@techjini.com
```

## Docker
```bash
# start docker
$ docker-machine start dev
$ eval "$(docker-machine env dev)"
```

## Installation

### MAC

#### Unix image on Mac

boot2docker

link for [port forwarding](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md)

##### Change docker-machine memory
```bash
$ docker-machine stop dev
$ VBoxManage modifyvm dev --memory 4096
$ docker-machine start dev
```

#### Windows image on Mac
```Note
Note!
docker image of windowserver do not run on Mac.
Hence, install windows VM, and execute docker for windows inside it.
(windows docker machine inside headless vagrant vm)
```

##### Installion Steps
- install packer from *[Download Packer - Packer by HashiCorp](https://www.vagrantup.com/downloads.html)* ([google search](https://www.google.co.in/search?q=vagrant+packer+download&oq=packer+vagrant+download&aqs=chrome.1.69i57j0.19814j0j7&sourceid=chrome&ie=UTF-8))

- install vagrant from *[Download - Vagrant by HashiCorp](https://www.vagrantup.com/downloads.html)* ([google search](https://www.google.co.in/search?q=download+vagrant&oq=downl&aqs=chrome.0.0l2j69i60l2j69i59j69i57.1727j0j4&sourceid=chrome&ie=UTF-8))

- install [`Windows Docker Machine`](https://github.com/StefanScherer/windows-docker-machine)

```bash
$ packer build --only=virtualbox-iso windows_2016_docker.json
$ vagrant box add windows_2016_docker windows_2016_docker_virtualbox.box
```

### Windows Server 2016/Windows 10

Article [here](https://blog.couchbase.com/setup-docker-windows-server-2016/)

[Google search](https://www.google.co.in/search?newwindow=1&ei=KFBbWpLCBIKo8QXMgYTYDg&q=install+docker+on+windows+server+2016&oq=getting+started+with+docker+on+windows+2016+server&gs_l=psy-ab.3.2.0i71k1l4.0.0.0.93835.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.cDOVuANE4x4)

#### Steps
```ps

Find-ContainerImage

Install-ContainerImage -Name WindowsServerCore

Invoke-WebRequest https://aka.ms/tp5/Update-Container-Host -OutFile update-containerhost.ps1



```
