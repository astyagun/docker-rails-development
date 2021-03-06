# Docker-based local development environment

## Setup

Requirements:

- macOS
- [Docker for Mac](https://docs.docker.com/docker-for-mac/)
- [docker-sync](http://docker-sync.io)

```sh
docker-sync start

docker-compose run --rm spring bundle install
docker-compose run --rm spring rails db:prepare

docker-compose up -d
docker-compose ps
```

If all containers are "Up", visit <http://localhost:3000> to check if the application is running

## Usage

Run all shell commands through the Spring container. Examples:

```sh
docker-compose exec spring spring rspec
docker-compose exec spring spring rake db:migrate
docker-compose exec spring tail -f log/development.log
docker-compose exec spring bash
```

### Recommended Zsh aliases

<https://github.com/akarzim/zsh-docker-aliases>

```sh
# Docker
alias dksyn='docker-sync'
alias dksynl='dksyn logs'
alias dksynr='dksyn stop && dksyn start'
alias dksynw="watch 'docker-sync logs | tail -n40'"
alias down='dkcd; dksyn clean'
alias ds='dkce spring'
alias dsd='dkce --env RAILS_ENV=development spring'
alias dst='dkce --env RAILS_ENV=test spring'
alias start='dksyn start &; dkcU &; wait'
alias stop='dksyn stop &; dkcx &; wait'
alias up='dksyn start; dkcU'

# Ruby and Rails in Docker
alias bundle='ds bundle'
alias rails='ds spring rails'
alias rake='ds spring rake'
alias rspec='dst spring rspec'
```
