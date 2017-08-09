FROM ruby:2.4

# Install NodeJS
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  nodejs \
  vim \
  && rm -rf /var/lib/apt/lists/*

# Install PhantomJS
RUN mkdir /tmp/phantomjs \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  | tar -xj --strip-components=1 -C /tmp/phantomjs \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

RUN adduser --disabled-password --gecos "" myuser
USER myuser

RUN bundle config jobs 4

RUN echo "\
syntax on\n\
filetype plugin indent on\n\
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab number laststatus=2 title hlsearch incsearch\n\
autocmd BufRead *.yml.enc set filetype=eruby.yaml\n"\
> ~/.vimrc
ENV EDITOR=vim

WORKDIR /usr/src/app

ENTRYPOINT ["spring"]
CMD ["server"]
