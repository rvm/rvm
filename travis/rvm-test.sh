#!/usr/bin/env bash

cd rvm-test
env time -f "# took: %E" ruby bin/run.rb --script batch_scripts/fast --short
