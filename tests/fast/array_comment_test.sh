source "$rvm_path/scripts/rvm"

: __rvm_remove_from_array
arr=( working on a problem or problem/test and not other/problem )
__rvm_remove_from_array arr "*problem*" "${arr[@]}" # env[arr][]=6; env[arr][]!=/problem/
arr=( working on a problem or problem/test and not other/problem )
__rvm_remove_from_array arr "problem*" "${arr[@]}" # env[arr][]=7

: add/remove
__rvm_remove_from_path /test-bin    # env[PATH]!=//test-bin/
