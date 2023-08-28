#! /usr/bin/env bash

# Compile assets
bundle exec rake assets:precompile

# Clear previous assets
bundle exec rake assets:clean

# Start server
bin/rails server -b 0.0.0.0
