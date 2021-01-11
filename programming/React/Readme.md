# React

## cheatsheet
```bash
# create react app

# in docker
$ docker run --rm -it -v `pwd`:/app -w /app node:10-alpine /bin/sh

$ npx create-react-app spa

# add scss
$ npm install node-sass@4.9 --save
```

## Ref

[11 React Boilerplates and Starter Kits for 2019](https://blog.bitsrc.io/11-react-application-boilerplates-for-2019-b49a8226ea54)

[Axios Crash Course | HTTP Library](Axios Crash Course | HTTP Library)

https://www.udemy.com/course/modern-react-front-to-back/

[React Redux Universal Hot Example](https://github.com/erikras/react-redux-universal-hot-example)

## coding
Difference in following function assignments:
```javascript
<Component onClick={ onMyClick } />
// On click of component will call onMyClick(). Assigning def to onClick

<Component onClick={ ()=> onMyClick() } />
// Here we have created a anonymous fun and assigned

<Component newProp={ myFunc() } />
// At the time of component creation, myFunc() will be executed and it
```
## api url

Note: _Env variables should start with REACT_APP_ otherwise NODE_ENV variables are a bit confused and your environment variable will not work:_

### passing from `docker-compose.yml`
```docker-compose
version: "3.3"

services:
  api:
    ... //api config
  spa:
    ...
    environment:
      - REACT_APP_API_URL=api:5000
```

### passing from `Dockerfile`
```Dockerfile
ENV REACT_APP_API_URL=localhost:5000
```


passing api url from docker/docker-compose

ref: https://stackoverflow.com/questions/52103155/reading-an-environment-variable-in-react-which-was-set-by-docker

Env variables should start with REACT_APP_ otherwise NODE_ENV variables are a bit confused and your environment variable will not work:

environment:
  - REACT_APP_DEBUG=TRUE

Otherwise, docker-compose.yml is not valid and you will see an error message:

## HTTPS
create cert

ref: [Using HTTPS in Development](https://create-react-app.dev/docs/using-https-in-development/), 
```bash
openssl req -x509 -newkey rsa:2048 -keyout keytmp.pem -out cert.pem -days 365
openssl rsa -in keytmp.pem -out cert.key

# run with command
HTTPS=true&&SSL_CRT_FILE=cert.pem&&SSL_KEY_FILE=key.pem npm start

# or update start script

# or in Dockerfile set
ENV HTTPS=true
ENV SSL_CERT_FILE=cert.pem
ENV SSL_KEY_FILE=cert.key
```
