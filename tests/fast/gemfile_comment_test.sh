source "$rvm_path/scripts/rvm"

: settings
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvmrc
f_rvmrc=$d/.rvmrc
f_gemfile=$d/sub/Gemfile

: prepare1
rvm use 3.3.13 --install
rvm gemset create gemfile
rvm gemset create rvmrc
mkdir -p $d/sub
printf "rvm use 3.3.13@rvmrc\n"   > $f_rvmrc

: test1
rvm current           # match=/^ruby-3.3.13$/
rvm_current_rvmrc=""
rvm rvmrc load $d/sub # status=0; match=/Using .*ruby-3.3.13.*rvmrc/
rvm current           # match=/^ruby-3.3.13@rvmrc$/

: prepare2
rvm use 3.3.13
printf "source :rubygems\n\ngem 'haml'\n" > $f_gemfile

: test2
rvm current           # match=/^ruby-3.3.13$/
rvm_current_rvmrc=""
rvm rvmrc load $d/sub # status=0; match=/Using .*ruby-3.3.13.*rvmrc/
rvm current           # match=/^ruby-3.3.13@rvmrc$/

: prepare3
rvm use 3.3.13
## escape # -> \x23
printf "source :rubygems\n\x23ruby=3.3.13\n\x23ruby-gemset=gemfile\ngem 'haml'\n" > $f_gemfile

: test3
rvm current           # match=/^ruby-3.3.13$/
rvm_current_rvmrc=""
rvm rvmrc load $d/sub # status=0; match!=/Using .*ruby-3.3.13.*rvmrc/
rvm current           # match=/^ruby-3.3.13@gemfile$/

: clean
rvm use 3.3.13
rvm --force gemset delete gemfile
rvm --force gemset delete rvmrc
rm -rf $d
