# Development Process

<!-- vim-markdown-toc GFM -->

* [Development](#development)
  * [Environment Variables](#environment-variables)
    * [Stratagy 1: Refrencial folder](#stratagy-1-refrencial-folder)
    * [Stratagy 2: Commandline Utility](#stratagy-2-commandline-utility)
    * [Core Lib to access Env](#core-lib-to-access-env)
  * [Installation Script](#installation-script)
* [Core Lib Development](#core-lib-development)
* [UI Development](#ui-development)
  * [Quick Start](#quick-start)
* [API Development](#api-development)
  * [Quick Start](#quick-start-1)
* [Deployment](#deployment)
  * [Vanila Deployment VM](#vanila-deployment-vm)

<!-- vim-markdown-toc -->

## Development
### Environment Variables

#### Stratagy 1: Refrencial folder
* the deployment structure of the code will be fixed
* the root folder of the deployment will have the `Environment Settings` `yml`

#### Stratagy 2: Commandline Utility
* `GoLang` utility `xxx` will store all the `Environment Settings` in `yml`
* these `Environment Settings` will be accessed with respet to the
  * tenant
  * installation folder
  * the codes config will not have the identifier

#### Core Lib to access Env
* `Core Lib` will have method to provide `Environment Settings`

### Installation Script
* `Apps Installation Script` should
  * access `Environment Settings` for
    * DB Server
    * DB Name
  * Setup DataBase
  * Do not set the DB Config in the app.config

## Core Lib Development
* Core files will be in separate git repo `Core Repo`
* Each app will inclue the `Core Repo` as a `git submodule`

## UI Development

Please read
  * [Environment Variables](#environment-variables)
  * [Core Lib Development](#core-lib-development)

### Quick Start

TBD

## API Development

Please read
  * [Environment Variables](#environment-variables)
  * [Core Lib Development](#core-lib-development)

### Quick Start

TBD

## Deployment

### Vanila Deployment VM
* Box to test the Installation
* QA will check if the system can be deployed using the `Apps Installation Script`
