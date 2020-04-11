#!/bin/bash

pushd $(dirname $0) &> /dev/null

gem install bundler:1.17.2
bundle config set without 'development test'
bundle install
RACK_ENV="production" APP_HOME=$(pwd) bundle exec rackup

popd &> /dev/null
