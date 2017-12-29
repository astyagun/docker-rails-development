FROM ruby:2.4

# TODO: Replace PhantomJS with Chrome headless
# Install PhantomJS
RUN mkdir /tmp/phantomjs/ \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  | tar -xj --strip-components=1 -C /tmp/phantomjs/ \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin/ \
  && rm -rf /tmp/phantomjs/

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    \
    less \
    nodejs \
    vim \
    \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create user
RUN adduser --disabled-password --gecos '' app
USER app

# Vim (for `rails secrets:edit`) and Bash settings
RUN echo "\
syntax on\n\
filetype plugin indent on\n\
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab number laststatus=2 title hlsearch incsearch\n\
autocmd BufRead *.yml.enc set filetype=eruby.yaml\n"\
  > ~/.vimrc \
  && echo alias la=ls -la >> ~/.bashrc
ENV EDITOR=vim

# Various settings
RUN bundle config jobs 4

WORKDIR /usr/src/app

CMD ["spring", "server"]
