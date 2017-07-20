FROM ruby:2.4

# Install NodeJS
RUN apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" myuser
USER myuser

RUN bundle config jobs 4

WORKDIR /usr/src/app

EXPOSE 3000
CMD rm -f tmp/pids/server.pid; rails server --binding 0.0.0.0
