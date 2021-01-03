# Docker

## Docker Hub
```bash
# login to docker hub
> docker login
... use docker hub id (not email)

# eg
$ docker login --username=jatintechjini --email=jatin@techjini.com
```

## Commands
```powershell
> docker info
> docker version
> docker ps
> docker images
> docker pull <image>
> docker run <image>
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

### Windows Pro

On installing docker for windows use following option
	 [ X ] Use Windows containers instead of Linux containers (this can be changed after installation)
    
## Docker Concepets

### Docker RUN vs CMD vs ENTRYPOINT

When working with Dockerfiles we often use the RUN, CMD, and ENTRYPOINT commands. The differences are as follows. The RUN command executes the given commands in a new layer (creates a new intermediary layer). It is often used to install required packages, libraries as well as the main application that is to be run inside the container. The CMD command is used to set default commands, which is executed when the container is run without command parameters. When the image is run with a command parameter, then the CMD commands are ignored. For example:

```Dockerfile
CMD echo "Hello!"

The above is ignored if we run the image with:

docker run -it <sampleImage> /bin/bash
```

The ENTRYPOINT command defines what is to be executed when the image runs. It is similar to the CMD command, however, it is always executed regardless of parameters passed in during the ‘docker run’. For example, the following will print “Hello John” when executed.

```Dockerfile
ENTRYPOINT ["/bin/echo", "Hello"]
CMD ["World"]
...
docker run -it <sampleImage> John
...
>> Hello John
```

Each of the RUN, CMD and ENTRYPOINT commands can be executed in shell-form or exec-form. See section below for details on these different forms.

### Docker Shell-Form vs Exec-Form commands

When writing out Docker commands in the Dockerfile you will notice two different form types. Example:
```Dockerfile
RUN dotnet restore
vs
RUN ["dotnet", "restore"]
```

The first command is a ‘shell form’ command – meaning it will be executed in the shell within the container. The second command is in ‘exec form’ and takes a JSON array as an argument (the array must use double quotes between the values, no single quotes). The ‘exec form’ does not invoke a command shell. The advantage with using the ‘exec form’ is it avoids issues with shell command parameters and any shell signal processing. Though these could also be advantages of using the ‘shell form’ – as it is useful when having chained shell commands (using pipes or &&), use of environment variables or specific shell parameters.
