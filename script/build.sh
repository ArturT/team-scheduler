#!/bin/bash -i

rvm 1.9.3-p194

export RAILS_ENV=test

bundle install --without production --without staging --without development;
[ -f $WORKSPACE/config/database.yml ] || ln -s $WORKSPACE/../config/database.yml $WORKSPACE/config/database.yml;

bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate

bundle exec rspec -I. spec/ --tag ~js
