# general

1. Try to make code readable, it's the most important rule,
turn your eyes away from code and look on it again,
can you really fast understand it - if no - reformat to make it better.

2. Avoid semicolons, just because they make code harder to read (look rule 1).

# variables

## defining
```bash
typeset var          # avid local - it breaks code in some rare cases
typeset -a arr
arr=()               # define and reset array, required for arr+=( ... )
typeset -x important # the same export, just for consistency
```

Variables defined in one local in function are available in all other functions called by it.

## numeric variables comparison
```bash
: variable:${variable:=0} # make sure it is set and simplifies debugging
(( variable ))      # when not zero
(( variable == 0 )) # when zero
: $(( variable++ )) # increase
```

## string variables comparison
```bash
[[ -n "${var:-}" ]]       # var is set
[[ "${var:-}" == "bla" ]] # var equals bla
[[ -n "${var1:-}" &&      # multi line check, first check has to be after [[ - for Zsh
  -n "${var2:-}" &&
  -n "${var3:-}"
]]
```

## multiple values check
```
case "$action" in
  (show)
    cat $1
    ;;
  (edit)
    ${EDITOR:-vim} $1
    ;;
  (help)
    echo "Usage this [show|edit]"
    ;;
esac
```

## dynamic invocation
```bash
_show(){ cat $1 || return $?; }
_edit(){ ${EDITOR:-vim} $1 || return $?; }
action=_$1
shift
${action} "$@" ||
case $? in
  (127) echo "Unknown action '$action'." ;;
  (*)   echo "Error '$?' occurred."      ;;
esac
```

# if's

## dens form for short statements / commands
```bash
if [[ -n "${bla:-}" ]]
then x=bla
else x=
fi
```

## sparse form for long statements / more commands
```bash
if
  [[ -n "${bla_asd_sf_affdfs_dsf_sdf_sdf:-}" ]] ||
  [[ -n "${bar_Dfs_dsg_FG_fd_fd_df_dfgdf:-}" ]]
then
  some more commands
  and even more
else
  or other commands
fi
```

## mixed for large else
```bash
if [[ -n "${bla:-}" ]]
then x=bla
else
  x=...
  some more commands
  and even more
fi
```

## just else
```bash
[[ -n "${bla:-}" ]] ||
{
  x=...
  some more commands
  and even more
}
```

# loops

## params parsing
```bash
while
  (( $# ))
do
  case "$1" in
    (-s|--silent)
      silent_flag=1
      ;;
    (-n|--name)
      (( $# > 1 )) ||
      {
        printf "ERROR: name required"
        exit 1
      }
      bla_name_flag="$2"
      shift
      ;;
    (*)
      bla_extra_flags+=( "$1" )
      ;;
  esac
  shift
done
```

## params iterate
```bash
# the - in "$@" - is default
for __param
do echo "$__param"
done
```
