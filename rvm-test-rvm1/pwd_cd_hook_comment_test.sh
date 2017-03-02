source "$rvm_path/scripts/rvm"
source "$rvm_path/scripts/functions/rvmrc_project"
rvm_scripts_path="$rvm_path/scripts" rvm_project_rvmrc=cd source "$rvm_path/scripts/cd"

: setup basic
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvm-pwd-hook
mkdir -p $d/.rvm/hooks
f=$d/.rvm/hooks/after_cd_test
echo "echo test it" > $f
chmod +x $f

: test not trusted
cd $d
# match!=/^test it$/
# status=0

: test trusted
rvm rvmrc trust $f
cd $d
# match=/^test it$/
# status=0

: test untrusted
rvm rvmrc reset $f
cd $d
# match!=/^test it$/
# status=0

: cleanup
rm -rf $d

: setup spaces
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvm-pwd-hook
mkdir -p $d/.rvm/hooks
f="$d/.rvm/hooks/after_cd_test install.sh"
echo "echo test it" > "$f"
echo "echo spaces" > $d/.rvm/hooks/after_cd_test
echo "echo install" > $d/install.sh
chmod +x "$f" $d/.rvm/hooks/after_cd_test $d/install.sh

: test trusted
rvm rvmrc trust "$f"
cd $d
# match=/^test it$/
# match!=/^spaces$/
# match!=/^install$/
# status=0

: cleanup
rvm rvmrc reset $f
rm -rf $d
