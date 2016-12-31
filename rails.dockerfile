FROM ruby:2.4

# Install NodeJS
RUN apt-get update \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
