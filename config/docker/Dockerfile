FROM ruby:2.4.1
LABEL maintainer "Mitch Joa <mitchjoa@gmail.com>"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
   build-essential \
   nodejs \
   libpq-dev

ENV INSTALL_PATH /pocket
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
