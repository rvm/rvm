source "$rvm_path/scripts/rvm"
export rvm_rubies_path

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-user
mkdir -p $d
cd $d
rvm use 2.4.0 --install           # status=0
rvm use 2.4.1 --install --default # status=0

## use system
: loads default if nothing else set
rvm use system
# env[GEM_HOME]=/^$/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1 rvm_promptless=1 __rvm_project_rvmrc
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/

: load project
echo "2.4.0" > .ruby-version
rvm use system
# env[GEM_HOME]=/^$/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1
rvm_promptless=1
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0$/
# env[PATH]=/2.4.0/

: load project and gemset
echo "@test" > .ruby-gemset
rvm use system
# env[GEM_HOME]=/^$/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_create_flag=1
rvm_project_rvmrc_default=1
rvm_promptless=1
## ( set -x ; PS4=="+ \${BASH_SOURCE} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > " ; __rvm_project_rvmrc )
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0@test$/
# env[PATH]=/2.4.0@test/

## use default
: loads default if nothing else set
rm .ruby-version .ruby-gemset
rvm use default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1 rvm_promptless=1 __rvm_project_rvmrc
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/

: load project
echo "2.4.0" > .ruby-version
rvm use default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1
rvm_promptless=1
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0$/
# env[PATH]=/2.4.0/

: load project and gemset
echo "@test" > .ruby-gemset
rvm use default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_create_flag=1
rvm_project_rvmrc_default=1
rvm_promptless=1
## ( set -x ; PS4=="+ \${BASH_SOURCE} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > " ; __rvm_project_rvmrc )
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0@test$/
# env[PATH]=/2.4.0@test/

## source default
: loads default if nothing else set
rm .ruby-version .ruby-gemset
rvm use system
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
source $rvm_path/environments/default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1 rvm_promptless=1 __rvm_project_rvmrc
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/

: load project
echo "2.4.0" > .ruby-version
rvm use system
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
source $rvm_path/environments/default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_project_rvmrc_default=1
rvm_promptless=1
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0$/
# env[PATH]=/2.4.0/

: load project and gemset
echo "@test" > .ruby-gemset
rvm use system
source "$rvm_path/scripts/initialize"
# env[rvm_rubies_path]!=/^$/
source $rvm_path/environments/default
# env[GEM_HOME]=/2.4.1$/
# env[PATH]=/2.4.1/
rvm_current_rvmrc=""
rvm_previous_environment=""
rvm_create_flag=1
rvm_project_rvmrc_default=1
rvm_promptless=1
## ( set -x ; PS4=="+ \${BASH_SOURCE} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > " ; __rvm_project_rvmrc )
__rvm_project_rvmrc
# env[GEM_HOME]=/2.4.0@test$/
# env[PATH]=/2.4.0@test/

: teardown
rvm alias delete default 2.4.1
rm -rf $d
