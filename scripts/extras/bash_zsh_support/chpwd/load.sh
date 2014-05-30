[[ -n "${ZSH_VERSION:-}" ]] ||
{
  cd()    { __zsh_like_cd cd    "$@" ; }
  popd()  { __zsh_like_cd popd  "$@" ; }
  pushd() { __zsh_like_cd pushd "$@" ; }
}
