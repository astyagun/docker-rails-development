# Docker Rails development

Docker based Rails development environment

## Installation

* Clone this repository into directory next to the directory of your project
* `cd` into your project directory
* Run `../docker-rails-development/install`
* Replace `myapp` with your app name (as used in Docker Compose container names) in `docker-sync.yml` file
* Install dependencies
  * [Docker for Mac](https://docs.docker.com/docker-for-mac/)
  * [docker-sync](http://docker-sync.io) for fast access to local code from containers

## Usage

Having below aliases defined type in the shell:

```sh
start
```

Otherwise:

```sh
docker-sync start
docker-compose up -d
```

## Useful shell aliases

Depend on these: https://github.com/sorin-ionescu/prezto/tree/master/modules/docker

```sh
alias dt='dkce tests'
alias rspec='dt rspec'
alias start='docker-sync start; dkc up -d'
alias stop='docker-sync stop; dkc stop'
alias down='dkc down; docker-sync clean'
alias dsr='docker-sync stop && docker-sync start'
```
