: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-user
mkdir -p $d
cd $d
unset GEM_HOME GEM_PATH
PATH="$( echo $PATH | sed 's/^.*rvm[^:]*://' )" # env[PATH]!=/rvm/
"$rvm_path/bin/rvm" install 2.0.0-p353          # status=0
"$rvm_path/bin/rvm" 2.0.0-p353 do rvm gemset create test # status=0
"$rvm_path/bin/rvm" install 2.1.1               # status=0
"$rvm_path/bin/rvm" alias delete default        # status=0
"$rvm_path/bin/rvm" alias create default 2.1.1  # status=0

echo "2.0.0-p353" > .ruby-version
echo "test" > .ruby-gemset
source "$rvm_path/scripts/rvm"
# env[GEM_HOME]=/2.0.0-p353@test$/
# env[PATH]=/2.0.0-p353@test/

: teardown
rvm alias delete default 2.1.1
rm -rf $d
