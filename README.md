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
* Install Rails gem from a container
  ```sh
  docker-compose up -d # This will return errors, because there are no required executables in containers yet
  docker-compose run --rm web gem install rails
  ```
* Generate a new Rails application and install Spring to run tests. Customize `rails new` command as needed.
  ```sh
  APP_NAME=`basename $(pwd)`
  docker-compose run --rm web rails new $APP_NAME
  mv $APP_NAME/* $APP_NAME/.* .
  rm -rf $APP_NAME/
  ```
* If you already have existing Rails application and have Spring in `Gemfile`, then you only need to run
  ```sh
  docker-compose up -d # This will return errors, because there are no required executables in containers yet
  docker-compose run --rm web bundle install
  ```

## Usage

Having below aliases defined, run in the shell:

```sh
start
```

Otherwise:

```sh
docker-sync start
docker-compose up -d
```

## Useful shell aliases

Following aliases depend on these: https://github.com/sorin-ionescu/prezto/tree/master/modules/docker

```sh
alias dt='dkce tests'
alias rspec='dt rspec'
alias start='docker-sync start; dkc up -d'
alias stop='docker-sync stop; dkc stop'
alias down='dkc down; docker-sync clean'
alias dsr='docker-sync stop && docker-sync start'
```
