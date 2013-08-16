source "$rvm_path/scripts/rvm"
rvm_scripts_path=$rvm_path/scripts
source "$rvm_path/scripts/tools"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-user
mkdir -p $d

: rvm user none
printf "rvm_path=a\nrvm_gemset_path=b\n" > $d/.fake-rvmrc
tools_user_none $d/.fake-rvmrc
# status=0
cat $d/.fake-rvmrc
# match=/rvm_path=/
# match!=/rvm_gemset_path=/
