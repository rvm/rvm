__zsh_like_cd()
{
  \typeset __zsh_like_cd_hook
  if
    builtin "$@"
  then
    shift || true # remove the called method
    for __zsh_like_cd_hook in chpwd "${chpwd_functions[@]}"
    do
      if \typeset -f "$__zsh_like_cd_hook" >/dev/null 2>&1
      then "$__zsh_like_cd_hook" "$@" || break # finish on first failed hook
      fi
    done
    true
  else
    return $?
  fi
}
