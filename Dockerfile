FROM ruby:2.2.1-slim

RUN apt-get update -y && apt-get install -y git-core

ADD . /gem

WORKDIR /gem

RUN gem build populatr.gemspec

RUN gem install populatr-*.gem --no-rdoc --no-ri 

RUN rm -r /var/cache/apt /var/lib/apt/lists && apt-get purge -y git && apt-get autoremove -y

WORKDIR /

RUN rm -rf /gem

ENTRYPOINT ["populatr"]

CMD ["start"]
