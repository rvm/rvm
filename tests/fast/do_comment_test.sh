source "$rvm_path/scripts/rvm"

rvm use 2.6.6 --install # status=0
rvm gemset create test1 # status=0
rvm gemset create test2 # status=0
rvm use 2.4.0 --install # status=0

: do
rvm 8.9.9 do rvm gemdir # status=1; match=/is not installed/
rvm 2.6.6 do rvm gemdir # status=0; match=/2.6.6/
rvm 2.6.6@test0 do rvm gemdir # status=2; match=/Gemset .* does not exist/
rvm 2.6.6@test1 do rvm gemdir # status=0; match=/2.6.6@test1/
rvm 2.6.6@test2 do rvm gemdir # status=0; match=/2.6.6@test2/

rvm 2.6.6@global,2.6.6 do rvm gemdir
# status=0
# match=/ruby-2.6.6/lib/ruby/gems/2.6.0$/
# match=/2.6.6$/

rvm --force gemset delete test1 # status=0
rvm --force gemset delete test2 # status=0

: FIXME: The following tests have awful duplication due to https://github.com/mpapis/tf/issues/6

: -----------------------------------------------------------------
: do in directory with no version

true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvm-do-in
mkdir -p $d

: absolute directory
rvm in $d do rvm info ruby  # status=1; match=/Could not determine which Ruby to use/
rvm in $d do ruby --version # status=1; match=/Could not determine which Ruby to use/

: relative directory
cd $TMPDIR
rvm in test-rvm-do-in do rvm info ruby  # status=1; match=/Could not determine which Ruby to use/
rvm in test-rvm-do-in do ruby --version # status=1; match=/Could not determine which Ruby to use/

: current directory
cd $d
rvm in . do rvm info ruby  # status=1; match=/Could not determine which Ruby to use/
rvm in . do ruby --version # status=1; match=/Could not determine which Ruby to use/
rvm    . do rvm info ruby  # status=1; match=/Could not determine which Ruby to use/
rvm    . do ruby --version # status=1; match=/Could not determine which Ruby to use/

: -----------------------------------------------------------------
mkdir -p $d/2.6.6
echo "2.6.6" > $d/2.6.6/.ruby-version

: absolute directory
rvm in $d/2.6.6 do rvm info ruby  # status=0; match=/version: *"2.6.6/
rvm in $d/2.6.6 do ruby --version # status=0; match=/^ruby 2.6.6/

: relative directory
cd $d
rvm in 2.6.6 do rvm info ruby  # status=0; match=/version: *"2.6.6/
rvm in 2.6.6 do ruby --version # status=0; match=/^ruby 2.6.6/

: current directory
cd $d/2.6.6
rvm . do rvm info ruby  # status=0; match=/version: *"2.6.6/
rvm . do ruby --version # status=0; match=/^ruby 2.6.6/

: -----------------------------------------------------------------
ver=2.4.0
mkdir -p $d/2.4.0
echo "2.4.0" > $d/2.4.0/.ruby-version

: absolute directory
rvm in $d/2.4.0 do rvm info ruby  # status=0; match=/version: *"2.4.0/
rvm in $d/2.4.0 do ruby --version # status=0; match=/^ruby 2.4.0/

: relative directory
cd $d
rvm in 2.4.0 do rvm info ruby  # status=0; match=/version: *"2.4.0/
rvm in 2.4.0 do ruby --version # status=0; match=/^ruby 2.4.0/

: current directory
cd $d/2.4.0
rvm . do rvm info ruby  # status=0; match=/version: *"2.4.0/
rvm . do ruby --version # status=0; match=/^ruby 2.4.0/

## cleanup
rm -rf $d
