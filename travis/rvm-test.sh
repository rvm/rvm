#!/usr/bin/env bash

(
  cd rvm-test
  ruby bin/run.rb --script batch_scripts/fast --short
)
