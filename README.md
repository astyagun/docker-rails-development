# Docker Rails development

Docker based Rails development environment for macOS

Depends on [docker-sync](http://docker-sync.io) to share source code between host and containers. At least until the native solution is as fast on macOS (see related Docker for Mac [issue](https://github.com/docker/for-mac/issues/77)).

## Installation

### Docker configuration files

#### Copy Docker configuration files into you project directory

Copy them manually or:

* Clone this repository into directory next to the directory of your project
* `cd` into your project directory
* Run `../docker-rails-development/install`

#### Update configuration files to fit your project

* Update Ruby version at the first lines of `*.dockerfile` files

### Make sure dependencies are installed

* [Docker for Mac](https://docs.docker.com/docker-for-mac/)
* [docker-sync](http://docker-sync.io) for fast access to local code from containers

### Prepare the environment

#### When installing for existing application

* Make sure all the required gems (such as Spring and Sidekiq, for example) are in the `Gemfile`, then run:
  ```sh
  docker-sync start
  docker-compose run --rm spring bundle install
  ```

#### When creating a new application

* Install Rails gem from a container
  ```sh
  docker-compose run --rm spring gem install rails
  ```
* FIXME: Following commands don't always work as expected when copied and pasted into Terminal. Run the following code to generate a new Rails application and install bundled gems. Customize the `rails new` command as needed.
  ```sh
  APP_NAME=`basename $(pwd)`
  docker-sync start
  docker-compose run --rm spring rails new $APP_NAME
  mv $APP_NAME/* $APP_NAME/.* .
  rm -rf $APP_NAME/
  ```

## Starting containers

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
alias ds='dkce spring'
alias up='docker-sync start; dkc up -d'
alias start='docker-sync start &; dkc up -d &; wait'
alias stop='docker-sync stop &; dkc stop &; wait'
alias down='dkc down; docker-sync clean'
alias dsr='docker-sync stop && docker-sync start'
alias rspec='ds ./bin/rspec'
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
