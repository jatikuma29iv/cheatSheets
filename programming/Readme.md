# Refs

**AZURE**
- [Develop and deploy a containerized Node.js app with Visual Studio Code and Azure](https://docs.microsoft.com/en-us/azure/developer/javascript/how-to/develop-nodejs-on-azure)
  * Deploying Docker app on `Azure App Service`
  * [Hosting a private Docker registry](https://docs.microsoft.com/en-us/azure/developer/javascript/how-to/develop-nodejs-on-azure#hosting-a-private-docker-registry)
  * [Configuring a custom domain name](https://docs.microsoft.com/en-us/azure/developer/javascript/how-to/develop-nodejs-on-azure#configuring-a-custom-domain-name)
  * [Scaling up and out](https://docs.microsoft.com/en-us/azure/developer/javascript/how-to/develop-nodejs-on-azure#scaling-up-and-out)

**Node js**
 * [Debugging Node.js with Chrome DevTools](https://medium.com/@paul_irish/debugging-node-js-nightlies-with-chrome-devtools-7c4a1b95ae27)
 * [Node js debugging Guide](https://nodejs.org/en/docs/guides/debugging-getting-started/)

# Development Process

<!-- vim-markdown-toc GFM -->

* [Gaps/Challenges](#gapschallenges)
  * [Deployment/Release](#deploymentrelease)
  * [Branding Assets](#branding-assets)
  * [Development](#development)
  * [Jenkins](#jenkins)
* [Development](#development-1)
  * [Environment Variables](#environment-variables)
    * [IIS Deployment](#iis-deployment)
    * [Stratagy 1: Refrencial folder](#stratagy-1-refrencial-folder)
    * [Stratagy 2: Commandline Utility](#stratagy-2-commandline-utility)
    * [Core Lib to access Env](#core-lib-to-access-env)
* [Installation](#installation)
  * [Script](#script)
* [Core Lib Development](#core-lib-development)
* [UI Development](#ui-development)
  * [Structure](#structure)
    * [Approach](#approach)
  * [Quick Start](#quick-start)
* [API Development](#api-development)
  * [Quick Start](#quick-start-1)
* [Deployment](#deployment)
  * [Vanila Deployment VM](#vanila-deployment-vm)

<!-- vim-markdown-toc -->

## Gaps/Challenges

### Deployment/Release
* The `Environment Config` is not loosly coupled from the code
* We do not have `release scripts` for creating release and setting up `Environment`
* The deployment engineer lacks the skills of creating and executing `release scripts`

### Branding Assets
* The `branding assets` are part of the code
* `build scripts` for setting up code are missing

### Development

### Jenkins
* Jenkins helps quickly setting up QA/Staing Env, however, Production release still becomes a manual activity
* `release scripts` can solve the problem
  * `release scripts` will be use by `Jenkins`
  * and same can be used in prod manually to automate Prod deployment

## Development
### Environment Variables

#### IIS Deployment

IIS works with `web.config`.
Keep all the `Environment` specific configuration in it. eg:
* Database Connection
* Urls to other services

In case there are multiple services deployed. Use on top level `Web.config`

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

## Installation
### Script
* `Apps Installation Script` should
  * access `Environment Settings` for
    * DB Server
    * DB Name
  * Setup DataBase
  * Do not set the DB Config in the app.config

## Core Lib Development
* Core files will be in separate git repo `Core Repo`
* Each app will include the `Core Repo` as a `git submodule`

## UI Development
Please read
* [Environment Variables](#environment-variables)
* [Core Lib Development](#core-lib-development)

### Structure
Typically the UI is composed of:
* UI Components
* Controllers
* Assets (Css/img)
* Business Services

#### Approach
Approach should be keep above 3 decoupled
Assets should be kept in separate repo. It should be copied to `Assets` folder for App development.

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
