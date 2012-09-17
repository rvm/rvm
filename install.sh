#!/bin/bash
find $rvm_path/patches $rvm_path/patchsets -name '*railsexpress*' | xargs rm -rf
cp -rp patches patchsets $rvm_path

if [[ "`uname -a`" =~ (Darwin Kernel Version 12) ]]; then
  export CPPFLAGS=-I/opt/X11/include
fi

for i in "$@"; do
  rvm reinstall $i --patch railsexpress
done
