#!/bin/sh

brew install rbenv
rbenv install 2.7.2
rbenv global 2.7.2
gem install -N bundler
bundle config set path 'vendor/bundle'
bundle config set jobs 20
bundle config set retry 4
bundle install
