# Docker Rails development

Docker based Rails development environment

Depends on [docker-sync](http://docker-sync.io) to share source code between host and containers. At least until the native solution is as fast on macOS (see related Docker for Mac [issue](https://github.com/docker/for-mac/issues/77)).

## Installation

* Clone this repository into directory next to the directory of your project
* `cd` into your project directory
* Run `../docker-rails-development/install`
* Update Ruby version in `*.dockerfile` files
* Replace `myapp` with your app name (as used in Docker Compose container names, as seen in output of `docker ps`) in `docker-sync.yml` file
* Install dependencies
  * [Docker for Mac](https://docs.docker.com/docker-for-mac/)
  * [docker-sync](http://docker-sync.io) for fast access to local code from containers
* Install Rails gem from a container
  ```sh
  docker-compose up -d # This will return errors, because there are no required executables in containers yet
  docker-compose run --rm tests gem install rails
  ```
* Generate a new Rails application and install bundled gems. Customize `rails new` command as needed.
  ```sh
  APP_NAME=`basename $(pwd)`
  docker-sync start
  docker-compose run --rm tests rails new $APP_NAME
  mv $APP_NAME/* $APP_NAME/.* .
  rm -rf $APP_NAME/
  ```
* If you already have existing Rails application and all the required gems are in the `Gemfile` (such as Spring for tests and Sidekiq, for example), then you only need to run
  ```sh
  docker-sync start
  docker-compose up -d # This will return errors, because there are no required executables in containers yet
  docker-compose run --rm tests bundle install
  ```

## Usage

Having below aliases defined, run in the shell:

```sh
up
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
alias up='docker-sync start; dkc up -d'
alias start='docker-sync start &; dkc up -d &; wait'
alias stop='docker-sync stop &; dkc stop &; wait'
alias down='dkc down; docker-sync clean'
alias dsr='docker-sync stop && docker-sync start'
function rspec() { dt bash -ic "./bin/rspec $*" }
```

## Files and directories to add to .gitignore

```
# Docker
/.docker-sync/
```

And these, if you don't want to commit anything related to Docker into the repository:

```
/*.dockerfile
/.env
/docker-compose.yml
/docker-sync.yml
```
