FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  \
  nodejs \
  vim \
  less \
  \
  && rm -rf /var/lib/apt/lists/*

# Install PhantomJS
RUN mkdir /tmp/phantomjs \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  | tar -xj --strip-components=1 -C /tmp/phantomjs \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

# Create user
RUN adduser --disabled-password --gecos "" myuser
USER myuser

# Vim
RUN echo "\
syntax on\n\
filetype plugin indent on\n\
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab number laststatus=2 title hlsearch incsearch\n\
autocmd BufRead *.yml.enc set filetype=eruby.yaml\n"\
> ~/.vimrc
ENV EDITOR=vim

# Various settings
RUN bundle config jobs 4; \
  unset HTTP_PROXY http_proxy

WORKDIR /usr/src/app

ENTRYPOINT ["spring"]
CMD ["server"]
