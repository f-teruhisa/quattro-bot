FROM ruby:2.6.3-alpine3.10
LABEL maintainer="Teruhisa Fukumoto<f-teruhisa>"
WORKDIR  .
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle config set path 'vendor/bundle'
