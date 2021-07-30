source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-remote
mkdir $d
pushd $d
rvm remove --gems 2.6.6           # status=0
rvm use 2.6.6 --install --movable # status=0
rvm list
# match=/ruby-2.6.6/

: tast packaging
rvm prepare 2.6.6           # status=0
[[ -f ruby-2.6.6.tar.bz2 ]] # status=0

: remove it
rvm remove --gems 2.6.6     # status=0
rvm list
# match!=/ruby-2.6.6/

: get local ruby
rvm mount -r ruby-2.6.6.tar.bz2 # status=0
rvm list
# match=/ruby-2.6.6/
rvm use 2.6.6 # status=0; match[stderr]=/^$/

: clean
popd
rm -rf $d
