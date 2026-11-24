source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvmrc
mkdir $d
pushd $d
command rvm install 3.3.12
rvm 3.3.12 do rvm gemset reset_env
command rvm install 3.4.12 # status=0
rvm use 3.3.13 --install

: .rvmrc generated
rvm rvmrc create 3.3.12
[ -f .rvmrc ]         # status=0
rvm current           # match=/3.3.13/
rvm rvmrc trust .rvmrc
rvm rvmrc load .rvmrc # env[GEM_HOME]=/3.3.12$/ ; env[PATH]=/3.3.12/
rvm current           # match=/3.3.12/

: .rvmrc with use
rvm_current_rvmrc=""
echo "rvm use 3.3.13" > .rvmrc
rvm rvmrc trust .
rvm rvmrc load .
rvm current           # match=/3.3.13/

: .rvmrc without use
rvm_current_rvmrc=""
echo "rvm 3.4.12" > .rvmrc
rvm rvmrc trust
rvm rvmrc load
rvm current           # match=/3.4.12/

rm -f .rvmrc
rvm use 3.3.13

: .versions.conf
rvm rvmrc create 3.4.12 .versions.conf
[ -f .versions.conf ] # status=0
rvm current           # match=/3.3.13/
rvm rvmrc load .
rvm current           # match=/3.4.12/

rm -f .versions.conf
rvm use 3.3.13

: .ruby-version
rvm rvmrc create 3.4.12 .ruby-version
[ -f .ruby-version ]  # status=0
rvm current           # match=/3.3.13/
rvm rvmrc load .
rvm current           # match=/3.4.12/

rm -f .ruby-version
rvm use 3.3.13

: clean
popd
rm -rf $d
