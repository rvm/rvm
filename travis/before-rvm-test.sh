#!/usr/bin/env bash

./install
git submodule init
git submodule update
cd rvm-test/
cp example_configs/db/sqlite_config.yml       db/config.yml
cp example_configs/config/sqlite_database.yml config/database.yml
bundle install --without long
rake db:create db:migrate
cd -
