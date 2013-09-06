#!/usr/bin/env bash

# Install rubies via rvm and reload RUBIES
function mrvm()
{
  typeset __result=0
  # duplication marker jdgkjnfnkjdngjkfnd4fd
  if
    [[ -z "$rvm_path" ]]
  then
    typeset reset_rvm_path=true
    if [[ -n "${BASH_SOURCE:-$0}" && -f "${BASH_SOURCE:-$0}" ]]
    then
      export rvm_path="${BASH_SOURCE:-$0}"
      rvm_path="$( \cd "${rvm_path%/scripts/extras/chruby.sh}">/dev/null; pwd )"
    elif [[ -x "$HOME/.rvm/bin/rvm" ]]
    then export rvm_path="$HOME/.rvm"
    elif [[ -x "/usr/local/rvm/bin/rvm" ]]
    then export rvm_path="/usr/local/rvm"
    else return 127
    fi
  fi
  "$rvm_path/bin/rvm" "$@" || __result=$?
  RUBIES=($( ls -1d "$rvm_path/rubies"/* 2>/dev/null ))
  if [[ -n "${reset_rvm_path:-}" ]]
  then unset rvm_path reset_rvm_path
  fi
  return ${__result}
}
