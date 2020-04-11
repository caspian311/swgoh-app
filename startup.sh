#!/bin/bash

pushd $(dirname $0) &> /dev/null

gem install bundler:1.17.2
bundle install --without development test
RACK_ENV="production" APP_HOME=$(pwd) bundle exec rackup

popd &> /dev/null
