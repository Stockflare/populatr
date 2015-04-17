FROM ruby:2.2.1-slim

RUN apt-get update -y && apt-get install -y git-core

ADD . /gem

WORKDIR /gem

RUN rm -rf test

RUN gem build populatr.gemspec

RUN gem install populatr-*.gem

RUN rm -r /var/cache/apt /var/lib/apt/lists && apt-get purge -y git && apt-get autoremove -y

ENTRYPOINT ["populatr"]

CMD ["start"]
