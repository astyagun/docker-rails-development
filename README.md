# Docker Rails development environment

Docker based Rails development environment for macOS

Depends on [docker-sync](http://docker-sync.io) to share source code between host and containers, which is the most performant way currently

## Installation

### Docker configuration files

#### Copy Docker configuration files into you project directory

Copy them manually or:

* Clone this repository into directory next to the directory of your project
* `cd` into your project directory
* Run `../docker-rails-development/install`

#### Update configuration files to fit your project

* Update Ruby version at the first lines of `*.docker` files

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

Run one of the following commands to generate a new Rails application. Arguments are passed to the call of the `rails new` command. Customize them as needed.

```sh
# Use current directory name as application name by default
../docker-rails-development/rails-new --database=postgresql --skip-git --skip-test
```

Or

```sh
../docker-rails-development/rails-new custom_app_name --database=postgresql --skip-git --skip-test
```

You can also refer to the help:

```sh
../docker-rails-development/rails-new --help
  ```

## Files and directories to add to .gitignore

```gitignore
# Docker
/.docker-sync/
/config/solargraph_hints.rb
```
