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

## Windows image on Mac
```Note
Note!
docker image of windowserver do not run on Mac.
Hence, install windows VM, and execute docker for windows inside it.
(windows docker machine inside headless vagrant vm)
```

### Installion Steps
- install packer from [google search](https://www.google.co.in/search?q=vagrant+packer+download&oq=packer+vagrant+download&aqs=chrome.1.69i57j0.19814j0j7&sourceid=chrome&ie=UTF-8) [download](https://www.vagrantup.com/downloads.html)

- install vagrant from [google search](https://www.google.co.in/search?q=download+vagrant&oq=downl&aqs=chrome.0.0l2j69i60l2j69i59j69i57.1727j0j4&sourceid=chrome&ie=UTF-8) [download](https://www.vagrantup.com/downloads.html)

- install [`Windows Docker Machine`](https://github.com/StefanScherer/windows-docker-machine)

```bash
$ packer build --only=virtualbox-iso windows_2016_docker.json
$ vagrant box add windows_2016_docker windows_2016_docker_virtualbox.box
```
