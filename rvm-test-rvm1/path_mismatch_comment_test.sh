source "$rvm_path/scripts/rvm"

: test no error
rvm use 1.9.3 --install   # status=0
rvm version
# match!=/is not at first place/
# match!=/is not available/

: test GEM_HOME second
rvm use 1.9.3             # status=0
GEM_HOME=$GEM_HOME@global
rvm version               # match=/is not at first place/

: test GEM_HOME missing
rvm use 1.9.3             # status=0
GEM_HOME=$GEM_HOME@veve
rvm version               # match=/is not available/

: rvm-shell check
rvm use 1.9.3             # status=0
GEM_HOME=$GEM_HOME@veve
rvm-shell 1.9.3 -c 'true'
# match!=/is not at first place/
# match!=/is not available/

: cd + .rvmrc
rvm use 1.9.3
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-cd-rvmrc
mkdir -p $d
echo "rvm use 1.9.3@veve --create" >> $d/.rvmrc
rvm rvmrc trust $d/.rvmrc

cd $d
# match!=/is not at first place/
# match!=/is not available/
# env[GEM_HOME]=/@veve$/

rvm rvmrc reset $d/.rvmrc
rm -rf $d
