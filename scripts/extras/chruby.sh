#!/usr/bin/env bash

# Set RUBIES when sourced.
RUBIES=($( \command \ls -1d "$rvm_path/rubies"/* 2>/dev/null ))

# Install rubies via rvm and reload RUBIES
function mrvm()
{
  \typeset __result=0
  # duplication marker jdgkjnfnkjdngjkfnd4fd
  if
    [[ -z "$rvm_path" ]]
  then
    \typeset reset_rvm_path=true
    if [[ -n "${BASH_SOURCE:-$_}" && -f "${BASH_SOURCE:-$_}" ]]
    then
      export rvm_path="${BASH_SOURCE:-$_}"
      rvm_path="$( \command \cd "${rvm_path%/scripts/extras/chruby.sh}">/dev/null; pwd )"
    elif [[ -x "$HOME/.rvm/bin/rvm" ]]
    then export rvm_path="$HOME/.rvm"
    elif [[ -x "/usr/local/rvm/bin/rvm" ]]
    then export rvm_path="/usr/local/rvm"
    else return 127
    fi
  fi
  "$rvm_path/bin/rvm" "$@" || __result=$?
  RUBIES=($( \command \ls -1d "$rvm_path/rubies"/* 2>/dev/null ))
  if [[ -n "${reset_rvm_path:-}" ]]
  then unset rvm_path reset_rvm_path
  fi
  return ${__result}
}
