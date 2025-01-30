source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-remote
mkdir $d
pushd $d
rvm remove --gems 3.1.3           # status=0
rvm use 3.1.3 --install --movable # status=0
rvm list
# match=/ruby-3.1.3/

: tast packaging
rvm prepare 3.1.3           # status=0
[[ -f ruby-3.1.3.tar.bz2 ]] # status=0

: remove it
rvm remove --gems 3.1.3     # status=0
rvm list
# match!=/ruby-3.1.3/

: get local ruby
rvm mount -r ruby-3.1.3.tar.bz2 # status=0
rvm list
# match=/ruby-3.1.3/
rvm use 3.1.3 # status=0; match[stderr]=/^$/

: clean
popd
rm -rf $d
