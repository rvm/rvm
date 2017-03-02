source "$rvm_path/scripts/rvm"
source "$rvm_path/scripts/functions/rvmrc_project"
rvm_scripts_path="$rvm_path/scripts" rvm_project_rvmrc=cd source "$rvm_path/scripts/cd"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-ruby-env
mkdir -p $d
rvm use --install 2.1.1
typeset -a __file_env_variables rvm_saved_env

### test with disabled trusting
export rvm_trust_rvmrcs_flag=1

: simple file loading
printf "a\nb\n" > $d/.env
__rvm_file_load_env $d/.env ""
# env[__file_env_variables][]=2
# env[__file_env_variables][0]=/^a$/
# env[__file_env_variables][1]=/^b$/

: prefixed file loading
printf "env-c\nenv-d\n" > $d/.env
__rvm_file_load_env $d/.env "env-"
# env[__file_env_variables][]=2
# env[__file_env_variables][0]=/^c$/
# env[__file_env_variables][1]=/^d$/

: remove empty new lines and comments
printf "d\n\n\043e\nf\n" > $d/.env    ## \043 for # as tf has a parsing bug
__rvm_file_load_env $d/.env ""
# env[__file_env_variables][]=2
# env[__file_env_variables][0]=/^d$/
# env[__file_env_variables][1]=/^f$/

: setting env variables with save
rvm_saved_env=()
unset a b
__rvm_set_env "rvm_saved_env" a=1 b=2
# env[a]=/^1$/
# env[b]=/^2$/
# env[rvm_saved_env][]=2
# env[rvm_saved_env][0]=/^a=$/
# env[rvm_saved_env][1]=/^b=$/

: setting env variables without save
rvm_saved_env=()
unset a b
__rvm_set_env "" a=3 b=4
# env[a]=/^3$/
# env[b]=/^4$/
# env[rvm_saved_env][]=0

: load/unload from file
printf "a=1\nb=2\n" > $d/.env
rvm_saved_env=( a=3 b=4 )
__rvm_file_load_env $d/.env
__rvm_file_set_env
# env[a]=/^1$/
# env[b]=/^2$/
# env[rvm_saved_env][]=2
# env[rvm_saved_env][0]=/^a=3$/
# env[rvm_saved_env][1]=/^b=4$/
__rvm_file_env_check_unload
# env[a]=/^3$/
# env[b]=/^4$/
# env[rvm_saved_env][]=0

: load from file no execution
printf "a=\`uname\`\nb=\$(uname)\n" > $d/.env
__rvm_file_load_env $d/.env
__rvm_file_set_env
# env[a]=/^`uname`$/
# env[b]=/uname/

: cd + .ruby-env + ';;'
rvm_saved_env=()
cd
RAILS_ENV=""
printf "2.1.1" > $d/.ruby-version
printf "RAILS_ENV=development';echo bla>&2;'" > $d/.ruby-env
cd "$d"
# match!=/bla/
# match[stderr]!=/bla/
# env[RAILS_ENV]=/^development'/
# env[rvm_saved_env][]=1
# env[rvm_saved_env][0]=/^RAILS_ENV=$/
cd
# env[RAILS_ENV]=/^$/
# env[rvm_saved_env][]=0
rm $d/.ruby-version

: cd + .ruby-env + ''
rvm_saved_env=()
cd
RAILS_ENV=""
printf "2.1.1" > $d/.ruby-version
printf "RAILS_ENV='development'" > $d/.ruby-env
cd "$d"
# env[RAILS_ENV]=/^development$/
# env[rvm_saved_env][]=1
# env[rvm_saved_env][0]=/^RAILS_ENV=$/
cd
# env[RAILS_ENV]=/^$/
# env[rvm_saved_env][]=0
rm $d/.ruby-version

: cd + Gemfile + ""
cd
RAILS_ENV="production"
printf "\043ruby=2.1.1\n" > $d/Gemfile
printf "\043ruby-env-RAILS_ENV=\"development\"\n" >> $d/Gemfile
printf "gem 'rvm'\n" >> $d/Gemfile
cd "$d"
# env[RAILS_ENV]=/^development$/
# env[rvm_saved_env][]=1
# env[rvm_saved_env][0]=/^RAILS_ENV=production$/
cd
# env[RAILS_ENV]=/^production$/
# env[rvm_saved_env][]=0
rm $d/Gemfile

: cd + .versions.conf
cd
BLA0="test"
printf 'ruby=2.1.1\n' > $d/.versions.conf
printf 'env-BLA0=`development`\n' >> $d/.versions.conf
printf 'env-BLA1=\`development\`\n' >> $d/.versions.conf
printf 'env-BLA2=\\`development\\`\n' >> $d/.versions.conf
printf 'env-BLA3=\\\`development\\\`\n' >> $d/.versions.conf
printf 'env-BLA4=\\\\`development\\\\`\n' >> $d/.versions.conf
printf 'env-BLA5=\\\\\`development\\\\\`\n' >> $d/.versions.conf
printf 'env-BLA6=\\\\\\`development\\\\\\`\n' >> $d/.versions.conf
cd "$d"
# match!=/bla/
# match[stderr]!=/bla/
# env[BLA0]=/^`development`$/
# env[BLA1]=/^\\`development\\`$/
# env[BLA2]=/^\\`development\\`$/
# env[BLA3]=/^\\\\`development\\\\`$/
# env[BLA4]=/^\\\\`development\\\\`$/
# env[BLA5]=/^\\\\\\`development\\\\\\`$/
# env[BLA6]=/^\\\\\\`development\\\\\\`$/
# env[rvm_saved_env][]=7
# env[rvm_saved_env][0]=/^BLA0=test$/
cd
# env[BLA0]=/^test$/
# env[rvm_saved_env][]=0
rm $d/.versions.conf

### test with enabled trusting
unset rvm_trust_rvmrcs_flag

: cd + .ruby-env + ''
rvm_saved_env=()
cd
RAILS_ENV=""
printf "2.1.1" > $d/.ruby-version
printf "RAILS_ENV='development'" > $d/.ruby-env
rvm rvmrc reset $d/.ruby-env
cd "$d"
# env[RAILS_ENV]=/^$/
# env[rvm_saved_env][]=0
cd
# env[RAILS_ENV]=/^$/
# env[rvm_saved_env][]=0
rvm rvmrc trust $d/.ruby-env
# match=/Marked .*\/.ruby-env as trusted/
# match!=/Marked .*\/.rvmrc as trusted/
cd "$d"
# env[RAILS_ENV]=/^development$/
# env[rvm_saved_env][]=1
# env[rvm_saved_env][0]=/^RAILS_ENV=$/
cd
# env[RAILS_ENV]=/^$/
# env[rvm_saved_env][]=0
rvm rvmrc reset $d/.ruby-env
rm $d/.ruby-version

: cleanup
rm -rf $d
