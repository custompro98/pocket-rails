FROM ruby:2.6.5
LABEL maintainer "Mitch Joa <mitchjoa@gmail.com>"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
   build-essential \
   nodejs \
   libpq-dev

ENV WORKDIR /pocket
RUN mkdir -p $WORKDIR

WORKDIR $WORKDIR

COPY Gemfile $WORKDIR/Gemfile
COPY Gemfile.lock $WORKDIR/Gemfile.lock
RUN bundle install && cp Gemfile.lock /tmp

COPY . $WORKDIR

EXPOSE 3000

ENTRYPOINT ["sh", "entrypoint.sh"]
CMD ["rails", "server"]