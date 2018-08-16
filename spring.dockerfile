FROM ruby:2.5

# TODO: Replace PhantomJS with Chrome headless
# Install PhantomJS
RUN set -ex \
  && echo Installing PhantomJS... \
  && mkdir /tmp/phantomjs/ \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | tar -xj --strip-components=1 -C /tmp/phantomjs/ \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin/ \
  && rm -rf /tmp/phantomjs/

# Install application dependencies
RUN set -ex \
  && echo Installing applicaiton dependencies... \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    less \
    nodejs \
    vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Run as root
RUN set -ex \
  && echo Updating RubyGems... \
  && gem update --system

RUN set -ex \
  && echo Writing docker-entrypoint... \
  && echo "#!/bin/sh\n\
rm -rf /tmp/.X0-lock /tmp/.X11-unix /tmp/spring-1000\n\
Xvfb :0 &\n\
spring server\n"\
    > /usr/local/bin/docker-entrypoint \
  && chmod +x /usr/local/bin/docker-entrypoint

# Create user
RUN adduser --disabled-password --gecos '' app
USER app

# Run as user
RUN set -ex \
  && echo Writing Vim settings... \
  && echo "\
syntax on\n\
filetype plugin indent on\n\
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab number laststatus=2 title hlsearch incsearch\n\
autocmd BufRead *.yml.enc set filetype=eruby.yaml\n"\
    > ~/.vimrc \
  \
  && echo Making other preparations... \
  && bundle config jobs 4 \
  && echo "alias la='ls -lhA'" >> ~/.bashrc

ENV EDITOR=vim DISPLAY=:0

WORKDIR /usr/src/app

CMD ["docker-entrypoint"]
