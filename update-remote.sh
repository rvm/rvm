#!/usr/bin/env bash

echo "Processing: remote - all"
ssh rvm@rvm.io -C ./rvm-list-binary.sh remote | sort > config/remote

for type in md5 sha512
do
  ssh rvm@rvm.io ./rvm-list-binary.sh $type | while IFS="=" read name value
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
