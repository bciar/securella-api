FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /securella-api
WORKDIR /securella-api
ADD Gemfile /securella-api/Gemfile
ADD Gemfile.lock /securella-api/Gemfile.lock
RUN bundle install
ADD . /securella-api
