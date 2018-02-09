FROM ruby:2.5

# Install application dependencies
RUN set -ex \
  \
  && echo Installing application dependencies... \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Run as root
RUN set -ex \
  \
  && echo Writing docker-entrypoint... \
  && echo "#!/bin/sh\n\
rm -f tmp/pids/server.pid\n\
rails server --binding 0.0.0.0\n"\
    > /usr/local/bin/docker-entrypoint \
  && chmod +x /usr/local/bin/docker-entrypoint

# Create user
RUN adduser --disabled-password --gecos '' app
USER app

WORKDIR /usr/src/app

CMD ["docker-entrypoint"]
