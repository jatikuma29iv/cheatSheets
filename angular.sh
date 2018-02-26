# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>

#angular
#npm setup
  npm upgrade -g npm
  npm install -g generator-karma

#start new project
  npm init
  npm install -g grunt-cli
  npm install grunt --save-dev
  npm install grunt-contrib-concat grunt-contrib-uglify grunt-ng-annotate --save-dev

#start new project with grunt and autocreate Gruntfile.js
  npm init
  npm install -g grunt-init
  git clone https://github.com/gruntjs/grunt-init-gruntfile.git ~/.grunt-init/gruntfile
  grunt-init gruntfile

#Yo Grunt Bower
  sudo npm install -g yo grunt-cli bower karma
  sudo npm install -g generator-angular

  mkdir project && cd $_
  yo angular

#Basics

Factory    - is a function which returns a type or function, can access services,do service initializations, lazy initializations  
Provider   - must implement $get, which is a factory
Service    - takes a type and creates a new object of the given type, but instanciation happens once
