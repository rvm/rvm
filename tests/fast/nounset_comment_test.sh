source "$rvm_path/scripts/rvm"

: loading and using RVM in a shell with nounset enabled, see issue 4694
bash -u -c 'source "$rvm_path/scripts/rvm" && rvm current' 2>&1 # status=0; match!=/unbound variable/
env -u USER bash -u -c 'source "$rvm_path/scripts/rvm" && rvm current' 2>&1 # status=0; match!=/unbound variable/

: reported flow, RVM loaded first and nounset enabled afterwards
bash -c 'source "$rvm_path/scripts/rvm"; set -eu -o pipefail; rvm use system && rvm current' 2>&1 # status=0; match=/system/; match!=/unbound variable/
env -u USER bash -c 'source "$rvm_path/scripts/rvm"; set -eu -o pipefail; rvm use system && rvm current' 2>&1 # status=0; match=/system/; match!=/unbound variable/

: cd hook is registered under nounset and existing hooks are kept
bash -u -c 'unset chpwd_functions; source "$rvm_path/scripts/rvm"; echo "${chpwd_functions[*]}"' 2>&1 # status=0; match=/^__rvm_cd_functions_set$/
bash -u -c 'chpwd_functions=(my_hook); source "$rvm_path/scripts/rvm"; echo "${chpwd_functions[*]}"' 2>&1 # status=0; match=/^my_hook __rvm_cd_functions_set$/
