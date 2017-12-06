FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    \
    nodejs \
    \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create user
RUN adduser --disabled-password --gecos '' app
USER app

WORKDIR /usr/src/app

EXPOSE 3000
CMD rm -f tmp/pids/server.pid; rails server --binding 0.0.0.0
