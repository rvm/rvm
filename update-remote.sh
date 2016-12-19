#!/usr/bin/env bash

echo "Linking: OSX binaries"
ssh rvm@ssh.rvm.io -C ./site/bin/rvm-link-binaries.sh osx 10.9

echo "Processing: remote - all"
ssh rvm@ssh.rvm.io -C ./site/bin/rvm-list-binary.sh remote | sort > config/remote

for type in md5 sha512
do
  ssh rvm@ssh.rvm.io ./site/bin/rvm-list-binary.sh $type | while IFS="=" read name value
  do
    echo "Processing: $type - $name"
    if \grep "^$name=" config/$type >/dev/null
    then sed -i.bak -e 's#^'"$name"'=.*$#'"$name=$value"'#' config/$type
    else echo "$name=$value" >> config/$type
    fi
  done
  LANG=C sort -n config/$type > config/$type.new
  mv -f config/$type.new config/$type
  rm config/$type.bak
done
