#!/usr/bin/env bash

# bash completion for Ruby Version Manager (RVM)

__rvm_comp()
{
  \typeset cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "$1" -- "$cur"))
  return 0
}

__rvm_subcommand()
{
  \typeset word subcommand c
  c=1

  while [[ $c -lt $COMP_CWORD ]] ; do
    word="${COMP_WORDS[c]}"
    for subcommand in $1; do
      if [[ "$subcommand" == "$word" ]]; then
        echo "$subcommand"
        return
      fi
    done
    c=$((++c))
  done
}

__rvm_rubies ()
{
  echo "$(rvm list strings) default system  $(rvm alias list names)"
}

__rvm_gemsets ()
{
  echo "$(rvm gemset list | __rvm_grep -v gemset 2>/dev/null)"
}

__rvm_help_pages ()
{
  ls "$rvm_help_path"
}

__rvm_known ()
{
  # Strips comments and expands known patterns into each variation
  rvm list known | __rvm_sed -e 's/#.*$//;' \
                       -e '/^$/d;' \
                       -e 's/^\[\(.*-\)\]\(.*\)\[\(-.*\)\]$/\1\2\3 \1\2 \2\3 \2/;' \
                       -e 's/^\[\(.*-\)\]\(.*\)$/\1\2 \2/;' \
                       -e 's/^\(.*\)\[\(-.*\)\]\[\(-.*\)\]$/\1\2\3 \1\2 \1/;' \
                       -e 's/^\(.*\)\[\(-.*\)\]$/\1\2 \1/ ' # | \command \tr ' ' "\n" | sort
}

_rvm_commands ()
{
  \typeset cur
  cur=${COMP_WORDS[COMP_CWORD]}

  COMMANDS='\
        version use reload implode update reset info debug\
        install uninstall reinstall remove\
        ruby gem rake tests specs monitor gemset\
        gemdir fetch list package notes snapshot\
        help automount disk-usage upgrade current migrate\
        alias autolibs cleanup cron docs get config-get\
        snapshot export fix-permissions repair rubygems\
        tools user info usage rvmrc osx-ssl-certs patchset\
        pkg group requirements do unexport wrapper'

  case "${cur}" in
  -*)       _rvm_opts ;;
  *)        __rvm_comp "$COMMANDS $(__rvm_rubies)" ;;
  esac
}

_rvm_opts ()
{
  RVM_OPTS='\
    -h\
    --help\
    -v\
    --version\
    -l --level\
    --bin\
    --gems\
    --archive\
    --patch
    -S\
    -e\
    -G\
    -C\
    --configure\
    --nice\
    --ree-options\
    --head\
    --rubygems\
    --default\
    --debug\
    --trace\
    --force\
    --summary\
    --latest\
    --docs\
    --reconfigure\
    --quiet-curl\
    --create'

  __rvm_comp "$RVM_OPTS"
}

_rvm_use ()
{
  \typeset _command
  _command="${COMP_WORDS[COMP_CWORD-2]}"

  case "${_command}" in
  gemset) __rvm_comp "$(__rvm_gemsets)" ;;
  *)      __rvm_comp "$(__rvm_rubies)" ;;
  esac
}

_rvm_gemset ()
{
  \typeset subcommand subcommands
  subcommands="import export create copy rename empty delete name dir list list_all gemdir install pristine clear use update unpack globalcache"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_remove ()
{
  \typeset subcommand subcommands
  subcommands="all old --gems --archive $(__rvm_rubies)"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_disk_usage()
{
  \typeset subcommand subcommands
  subcommands="all total archives docs repos sources logs pkg rubies gemsets wrappers tmp others"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_list()
{
  \typeset subcommand subcommands
  subcommands="help known remote gemsets default rubies strings known_strings ruby_svn_tags"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_reinstall()
{
  \typeset subcommand subcommands
  subcommands="$(rvm list strings)"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_uninstall()
{
  \typeset subcommand subcommands
  subcommands="$(rvm list strings) --gems"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_upgrade()
{
  \typeset subcommand subcommands
  subcommands="$(rvm list strings)"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_migrate()
{
  \typeset subcommand subcommands
  subcommands="$(rvm list strings)"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_autolibs()
{
  \typeset subcommand subcommands
  subcommands="disable disabled read read-only fail read-fail packages enable enabled reset status help show"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_cleanup()
{
  \typeset subcommand subcommands
  subcommands="all archives checksums repos sources logs gemsets links"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_cron()
{
  \typeset subcommand subcommands
  subcommands="setup remove"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_docs()
{
  \typeset subcommand subcommands
  subcommands="generate generate-ri generate-rdoc generate-gems rdoc_data"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_get()
{
  \typeset subcommand subcommands
  subcommands="stable latest head master branch help --auto-dotfiles --autolibs="
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_snapshot()
{
  \typeset subcommand subcommands
  subcommands="load save"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_fix_permissions()
{
  \typeset subcommand subcommands
  subcommands="user system"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_repair()
{
  \typeset subcommand subcommands
  subcommands="symlinks environments archives all"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_rubygems()
{
  \typeset subcommand subcommands
  subcommands="latest current master head"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_tools()
{
  \typeset subcommand subcommands
  subcommands="identifier path-identifier strings mirror rvm-env"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_user()
{
  \typeset subcommand subcommands
  subcommands="all gemsets"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_info()
{
  \typeset subcommand subcommands
  subcommands="$(rvm list strings) system rvm ruby homes binaries environment debug"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_rvmrc()
{
  \typeset subcommand subcommands
  subcommands="trust untrust trusted load reset create warning"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_osx_ssl_certs()
{
  \typeset subcommand subcommands
  subcommands="status update cron"
  subcommand="$(__rvm_subcommand "$subcommands")"

  if [[ -z "$subcommand" ]]; then
    __rvm_comp "$subcommands"
    return
  fi
}

_rvm_help ()
{
  __rvm_comp "$(__rvm_help_pages)"
}

_rvm_install ()
{
  __rvm_comp "$(__rvm_known)"
}

_rvm ()
{
  \typeset prev
  prev=${COMP_WORDS[COMP_CWORD-1]}

  case "${prev}" in
  use)      _rvm_use ;;
  gemset)   _rvm_gemset ;;
  help)     _rvm_help ;;
  install)  _rvm_install ;;
  autolibs) _rvm_autolibs ;;
  disk-usage) _rvm_disk_usage ;;
  reinstall) _rvm_reinstall ;;
  uninstall) _rvm_uninstall ;;
  upgrade)  _rvm_upgrade ;;
  list)     _rvm_list ;;
  remove)   _rvm_remove ;;
  migrate) _rvm_migrate ;;
  cleanup) _rvm_cleanup ;;
  snapshot) _rvm_snapshot ;;
  cron)    _rvm_cron ;;
  fix-permissions)    _rvm_fix_permissions ;;
  docs)    _rvm_docs ;;
  repair)    _rvm_repair ;;
  rubygems)    _rvm_rubygems ;;
  get)    _rvm_get ;;
  tools)    _rvm_tools ;;
  user)    _rvm_user ;;
  info)    _rvm_info ;;
  rvmrc)    _rvm_rvmrc ;;
  osx-ssl-certs)    _rvm_osx_ssl_certs ;;
  *)        _rvm_commands ;;
  esac

  return 0
}
