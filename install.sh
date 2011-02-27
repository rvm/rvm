#!/bin/bash
find $rvm_path -name '*railsexpress*' | xargs rm -rf
cp -rp . $rvm_path
