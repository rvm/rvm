#!/bin/bash
find $rvm_path/patches $rvm_path/patches -name '*railsexpress*' | xargs rm -rf
cp -rp patches patchsets $rvm_path
for i in "$@"; do
  rvm install $i --force --patch railsexpress
done
