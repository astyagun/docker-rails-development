# Docker Rails development

Docker based Rails development environment

## Installation

1. Clone this repository into directory next to the directory of your project
2. Cd into your project directory
3. Run `../docker-rails-development/install`
4. Replace `myapp` with your app name in `docker-sync.yml` file
4. Install dependencies
  * [Docker for Mac](https://docs.docker.com/docker-for-mac/)
  * [docker-sync](http://docker-sync.io) for fast access to local code from containers

## Usage

```sh
docker-sync start --daemon # Start Unison sync container as a background job
docker-compose up
```

## Useful aliases

```sh
alias dr='docker-compose run --rm rails'     # Example: dr bundle install
alias de='docker-compose exec spring'        # Example: de rake db:migrate
alias ds='docker-compose exec spring spring' # Example: ds rspec
```
