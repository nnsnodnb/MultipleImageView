#!/bin/sh

gem install -N bundler
bundle config set path 'vendor/bundle'
bundle config set jobs 4
bundle install
