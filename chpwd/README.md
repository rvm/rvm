# Bash support for Zsh like chpwd support

Implemented based on the description from
http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions

## Usage

1. execute content of `function.sh`, eg:

        source chpwd/functions.sh

2. add the hook - replace `_hook_name` with your function name:

        export -a chpwd_functions                              # define hooks as an shell array
        [[ " ${chpwd_functions[*]} " == *" _hook_name "* ]] || # prevent double addition
        chpwd_functions=( "${chpwd_functions[@]}" _hook_name ) # finally add it to the list

