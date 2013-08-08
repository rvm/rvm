source "$rvm_path/scripts/rvm"
rvm_project_rvmrc=cd source "$rvm_path/scripts/cd"

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

: test silencing
export rvm_silence_path_mismatch_check_flag=1
rvm use 1.9.3             # status=0
GEM_HOME=$GEM_HOME@veve
rvm version
# match!=/is not at first place/
# match!=/is not available/
unset rvm_silence_path_mismatch_check_flag

## cd + .rvmrc
: prepare
rvm use system
rvm alias delete default
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-cd-rvmrc
mkdir -p $d
echo "rvm use 1.9.3@veve --create" >> $d/.rvmrc
rvm rvmrc trust $d/.rvmrc

: entering
cd $d
# match!=/is not at first place/
# match!=/is not available/
# env[GEM_HOME]=/@veve$/

: leaving
cd ..
# match!=/is not at first place/
# match!=/is not available/
# env[GEM_HOME]=/^$/

: simulate 'rvm reload'
cd
rvm use 1.9.3@veve
rvm_promptless=1 __rvm_project_rvmrc
# match!=/is not at first place/
# match!=/is not available/
# env[GEM_HOME]=/@veve$/

rvm rvmrc reset $d/.rvmrc
rm -rf $d
