set -u
source "$rvm_path/scripts/rvm" # status=0
rvm use system                # status=0; match=/system/
[[ ":${SHELLOPTS:-}:" == *":nounset:"* ]]
# status=0
