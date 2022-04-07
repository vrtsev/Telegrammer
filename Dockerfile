FROM ruby:3.1.1-slim-buster
ENV LANG C.UTF-8

# "man" dirs creation prevents fail when install postgresql-client
# Try to remove them when decide to upgrade an image
RUN apt-get update -qq \
    && mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7 \
    && apt-get install \
    -y --no-install-recommends git build-essential libpq-dev postgresql-client \
    && rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /application
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
