FROM ruby:2.4.0
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /supersoakr
WORKDIR /supersoakr
COPY Gemfile /supersoakr/Gemfile
COPY Gemfile.lock /supersoakr/Gemfile.lock
RUN bundle install
COPY . /supersoakr
RUN RAILS_ENV=production bin/rails assets:precompile

