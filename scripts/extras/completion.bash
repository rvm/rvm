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
        help'

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
  subcommands="use create"
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
  *)        _rvm_commands ;;
  esac

  return 0
}
