source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvmrc
mkdir $d
pushd $d
command rvm install 2.4.1
rvm 2.4.1 do rvm gemset reset_env
rvm use 2.6.6 --install

: .rvmrc generated
rvm rvmrc create 2.4.1
[ -f .rvmrc ]         # status=0
rvm current           # match=/2.6.6/
rvm rvmrc trust .rvmrc
rvm rvmrc load .rvmrc # env[GEM_HOME]=/2.4.1$/ ; env[PATH]=/2.4.1/
rvm current           # match=/2.4.1/

: .rvmrc with use
rvm_current_rvmrc=""
echo "rvm use 2.6.6" > .rvmrc
rvm rvmrc trust .
rvm rvmrc load .
rvm current           # match=/2.6.6/

: .rvmrc without use
rvm_current_rvmrc=""
echo "rvm 3.0.5" > .rvmrc
rvm rvmrc trust
rvm rvmrc load
rvm current           # match=/3.0.5/

rm -f .rvmrc
rvm use 2.6.6

: .versions.conf
rvm rvmrc create 3.0.5 .versions.conf
[ -f .versions.conf ] # status=0
rvm current           # match=/2.6.6/
rvm rvmrc load .
rvm current           # match=/3.0.5/

rm -f .versions.conf
rvm use 2.6.6

: .ruby-version
rvm rvmrc create 3.0.5 .ruby-version
[ -f .ruby-version ]  # status=0
rvm current           # match=/2.6.6/
rvm rvmrc load .
rvm current           # match=/3.0.5/

rm -f .ruby-version
rvm use 2.6.6

: clean
popd
rm -rf $d
