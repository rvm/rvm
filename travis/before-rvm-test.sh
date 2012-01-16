#!/usr/bin/env bash

./install
(
  cd rvm-test/
  cp example_configs/db/sqlite_config.yml       db/config.yml
  cp example_configs/config/sqlite_database.yml config/database.yml
  rake db:create db:migrate
)
