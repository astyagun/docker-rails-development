# Docker local development environment

## Setup

Requirements:

* macOS (haven't tested on other platforms)
* [Docker for Mac](https://docs.docker.com/docker-for-mac/)
* [docker-sync](http://docker-sync.io)

```sh
docker-sync start
docker-compose build

docker-compose run --rm spring bundle install
docker-compose run --rm spring rails db:prepare

docker-compose up -d
docker-compose ps
```

If all containers are "Up", visit <http://localhost:3000> to check if the application is running

## Usage

Run all commands through the Spring container. Examples:

```sh
docker-compose exec spring spring rspec
docker-compose exec spring spring rake db:migrate
docker-compose exec spring bash
```

## Recommended Zsh aliases

<https://github.com/akarzim/zsh-docker-aliases>

```sh
# Docker
alias dksyn='docker-sync'
alias dksynr='dksyn stop && dksyn start'
alias down='dkcd; dksyn clean'
alias ds='dkce spring'
alias dsd='dkce --env RAILS_ENV=development spring'
alias dst='dkce --env RAILS_ENV=test spring'
alias start='dksyn start &; dkcU &; wait'
alias stop='dksyn stop &; dkcx &; wait'
alias up='dksyn start; dkcU'

# Rails in Docker
alias bundle='ds ./bin/bundle'
alias rails='ds ./bin/rails'
alias rake='ds ./bin/rake'
alias rspec='ds ./bin/rspec'
```
