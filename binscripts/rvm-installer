#!/usr/bin/env bash

BASH_MIN_VERSION="3.2.25"
if
  [[ -n "${BASH_VERSION:-}" &&
    "$(printf "%b" "${BASH_VERSION:-}\n${BASH_MIN_VERSION}\n" | LC_ALL=C sort -n -t"." | head -n1)" != "${BASH_MIN_VERSION}"
  ]]
then
  echo "BASH ${BASH_MIN_VERSION} required (you have $BASH_VERSION)"
  exit 1
fi

export HOME PS4
export rvm_trace_flag rvm_debug_flag rvm_user_install_flag rvm_ignore_rvmrc rvm_prefix rvm_path

shopt -s extglob
PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
set -o errtrace
set -o errexit

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

\which which >/dev/null 2>&1 || fail "Could not find 'which' command, make sure it's available first before continuing installation."
if
  [[ -z "${rvm_tar_command:-}" ]] && builtin command -v gtar >/dev/null
then
  rvm_tar_command=gtar
elif
  ${rvm_tar_command:-tar} --help 2>&1 | GREP_OPTIONS="" \grep -- --strip-components >/dev/null
then
  rvm_tar_command="${rvm_tar_command:-tar}"
else
  case "$(uname)" in
    (OpenBSD)
      log "Trying to install GNU version of tar, might require sudo password"
      if (( UID ))
      then sudo pkg_add -z gtar-1
      else pkg_add -z gtar-1
      fi
      rvm_tar_command=gtar
      ;;
    (Darwin|FreeBSD|DragonFly) # it's not possible to autodetect on OSX, the help/man does not mention all flags
      rvm_tar_command=tar
      ;;
    (SunOS)
      case "$(uname -r)" in
        (5.10)
          log "Trying to install GNU version of tar, might require sudo password"
          if (( UID ))
          then
            if \which sudo >/dev/null 2>&1
            then sudo_10=sudo
            elif \which /opt/csw/bin/sudo >/dev/null 2>&1
            then sudo_10=/opt/csw/bin/sudo
            else fail "sudo is required but not found. You may install sudo from OpenCSW repository (http://opencsw.org/about)"
            fi
            pkginfo -q CSWpkgutil || $sudo_10 pkgadd -a $rvm_path/config/solaris/noask -d http://get.opencsw.org/now CSWpkgutil
            sudo /opt/csw/bin/pkgutil -iy CSWgtar -t http://mirror.opencsw.org/opencsw/unstable
          else
            pkginfo -q CSWpkgutil || pkgadd -a $rvm_path/config/solaris/noask -d http://get.opencsw.org/now CSWpkgutil
            /opt/csw/bin/pkgutil -iy CSWgtar -t http://mirror.opencsw.org/opencsw/unstable
          fi
          rvm_tar_command=/opt/csw/bin/gtar
          ;;
        (*)
          rvm_tar_command=tar
          ;;
      esac
  esac
  builtin command -v ${rvm_tar_command:-gtar} >/dev/null ||
  fail "Could not find GNU compatible version of 'tar' command, make sure it's available first before continuing installation."
fi
if
  [[ ! " ${rvm_tar_options:-} " =~ " --no-same-owner "  ]] &&
  $rvm_tar_command --help 2>&1 | GREP_OPTIONS="" \grep -- --no-same-owner >/dev/null
then
  rvm_tar_options="${rvm_tar_options:-}${rvm_tar_options:+ }--no-same-owner"
fi

usage()
{
  printf "%b" "

Usage

  rvm-installer [options] [action]

Options

  [[--]version] <latest|latest-minor|latest-x|latest-x.y|x.y.z> - Install RVM version
  [--]branch    <name> - Install RVM head, from named branch
  --trace              - used to debug the installer script

Actions

  master - Install RVM master branch from wayneeseguin rvm repo (Default).
  stable - Install RVM stable branch from wayneeseguin rvm repo.
  help   - Display CLI help (this output)

Branches:

  branch <branch>
  branch /<branch>
  branch <repo>/
  branch <repo>/<branch>

  Defaults:

    branch: master
    repo:   wayneeseguin

"
}

## duplication marker 32fosjfjsznkjneuera48jae
__rvm_curl_output_control()
{
  if
    (( ${rvm_quiet_curl_flag:-0} == 1 ))
  then
    __flags+=( "--silent" "--show-error" )
  elif
    [[ " $*" =~ " -s" || " $*" =~ " --silent" ]]
  then
    # make sure --show-error is used with --silent
    [[ " $*" =~ " -S" || " $*" =~ " -sS" || " $*" =~ " --show-error" ]] ||
    {
      __flags+=( "--show-error" )
    }
  fi
}

## duplication marker 32fosjfjsznkjneuera48jae
# -S is automatically added to -s
__rvm_curl()
(
  __rvm_which curl >/dev/null ||
  {
    rvm_error "RVM requires 'curl'. Install 'curl' first and try again."
    return 200
  }

  typeset -a __flags
  __flags=( --fail --location --max-redirs 10 )

  if [[ -n "${rvm_proxy:-}" ]]
  then __flags+=( --proxy "${rvm_proxy:-}" )
  fi

  __rvm_curl_output_control

  unset curl
  __rvm_debug_command \curl "${__flags[@]}" "$@" || return $?
)

rvm_error()  { printf "ERROR: %b\n" "$*"; }
__rvm_which(){   which "$@" || return $?; true; }
__rvm_debug_command()
{
  if (( ${rvm_debug_flag:-0} ))
  then printf "Running($#): $*"
  fi
  "$@" || return $?
  true
}
rvm_is_a_shell_function()
{
  [[ -t 0 && -t 1 ]] || return $?
  return ${rvm_is_not_a_shell_function:-0}
}

#Searches for highest available version for the given pattern
# fetch_version 1.10. -> 1.10.3
# fetch_version 1. -> 1.11.0
# fetch_version "" -> 2.0.1
fetch_version()
{
  __rvm_curl -s https://api.github.com/repos/wayneeseguin/rvm/tags |
    sed -n '/"name": / {s/^.*".*": "\(.*\)".*$/\1/; p;}' |
    sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n -k 5,5n |
    GREP_OPTIONS="" \grep "^${1:-}" | tail -n 1
}

install_release()
{
  typeset _version
  _version=$1
  log "Downloading RVM version ${_version}"
  get_and_unpack \
    https://github.com/wayneeseguin/rvm/archive/${_version}.tar.gz \
    rvm-${_version}.tgz ||
  get_and_unpack \
    https://bitbucket.org/mpapis/rvm/get/${_version}.tar.gz \
    rvm-${_version}.tgz ||
  return $?
}

install_head()
{
  typeset _repo _branch
  case "$1" in
    (/*)
      _repo=wayneeseguin
      _branch=${1#/}
      ;;
    (*/)
      _repo=${1%/}
      _branch=master
      ;;
    (*/*)
      _repo=${1%%/*}
      _branch=${1#*/}
      ;;
    (*)
      _repo=wayneeseguin
      _branch=$1
      ;;
  esac
  case "${_repo}" in
    (mpapis|wayneeseguin)
      log "Downloading RVM from ${_repo} branch ${_branch}"
      get_and_unpack \
        https://github.com/${_repo}/rvm/archive/${_branch}.tar.gz \
        ${_repo}-rvm-${_branch//\//_}.tgz ||
      get_and_unpack \
        https://bitbucket.org/mpapis/rvm/get/${_branch}.tar.gz \
        ${_repo}-rvm-${_branch//\//_}.tgz ||
      return $?
      ;;
    (*)
      log "Downloading RVM from ${_repo} branch ${_branch}"
      get_and_unpack \
        https://github.com/${_repo}/rvm/archive/${_branch}.tar.gz \
        ${_repo}-rvm-${_branch//\//_}.tgz ||
      return $?
      ;;
  esac
}

# duplication marker dfkjdjngdfjngjcszncv
# Drop in cd which _doesn't_ respect cdpath
__rvm_cd()
{
    typeset old_cdpath ret
    ret=0
    old_cdpath="${CDPATH}"
    CDPATH="."
    chpwd_functions="" builtin cd "$@" || ret=$?
    CDPATH="${old_cdpath}"
    return $ret
}

get_and_unpack()
{
  typeset _url _file _patern _return
  _url=$1
  _file=$2

  __rvm_curl ${_url} -o ${rvm_archives_path}/${_file} ||
  {
    _return=$?
    case $_return in
      # duplication marker lfdgzkngdkjvnfjknkjvcnbjkncvjxbn
      (60)
        log "
Could not download '${_url}', you can read more about it here:
https://rvm.io/support/fixing-broken-ssl-certificates/
To continue in insecure mode run 'echo insecure >> ~/.curlrc'.
"
        ;;
      # duplication marker lfdgzkngdkjvnfjknkjvcnbjkncvjxbn
      (77)
        log "
It looks like you have old certificates, you can read more about it here:
https://rvm.io/support/fixing-broken-ssl-certificates/
"
        ;;
      # duplication marker lfdgzkngdkjvnfjknkjvcnbjkncvjxbn
      (141)
        log "
Curl returned 141 - it is result of a segfault which means it's Curls fault.
Try again and if it crashes more than a couple of times you either need to
reinstall Curl or consult with your distribution manual and contact support.
"
        ;;
      (*)
        log "
Could not download '${_url}'.
  curl returned status '$_return'.
"
        ;;
    esac
    return $_return
  }

  [[ -d "${rvm_src_path}/rvm" ]] || \mkdir -p "${rvm_src_path}/rvm"
  __rvm_cd "${rvm_src_path}/rvm" ||
  {
    _return=$?
    log "Could not change directory '${rvm_src_path}/rvm'."
    return $_return
  }

  rm -rf ${rvm_src_path}/rvm/*
  __rvm_debug_command $rvm_tar_command xzf ${rvm_archives_path}/${_file} ${rvm_tar_options:-} --strip-components 1 ||
  {
    _return=$?
    log "Could not extract RVM sources."
    return $_return
  }
}

# Tracing, if asked for.
if [[ "$*" =~ --trace ]] || (( ${rvm_trace_flag:-0} > 0 ))
then
  set -o xtrace
  rvm_trace_flag=1
fi

# Variable initialization, remove trailing slashes if they exist on HOME
true \
  ${rvm_trace_flag:=0} ${rvm_debug_flag:=0}\
  ${rvm_ignore_rvmrc:=0} HOME="${HOME%%+(\/)}"


if (( rvm_ignore_rvmrc == 0 ))
then
  for rvmrc in /etc/rvmrc "$HOME/.rvmrc"
  do
    if [[ -s "$rvmrc" ]]
    then
      if GREP_OPTIONS="" \grep '^\s*rvm .*$' "$rvmrc" >/dev/null 2>&1
      then
        printf "%b" "
Error: $rvmrc is for rvm settings only.
rvm CLI may NOT be called from within $rvmrc.
Skipping the loading of $rvmrc
"
        exit 1
      else
        source "$rvmrc"
      fi
    fi
  done
fi

if [[ -z "${rvm_path:-}" ]]
then
  if (( UID == 0 ))
  then
    rvm_user_install_flag=0
    rvm_prefix="/usr/local"
    rvm_path="${rvm_prefix}/rvm"
  else
    rvm_user_install_flag=1
    rvm_prefix="$HOME"
    rvm_path="${rvm_prefix}/.rvm"
  fi
fi
if [[ -z "${rvm_prefix}" ]]
then
  rvm_prefix=$( dirname $rvm_path )
fi

# duplication marker kkdfkgnjfndgjkndfjkgnkfjdgn
case "$rvm_path" in
  (/usr/local/rvm)         rvm_user_install_flag=0 ;;
  ($HOME/*|/${USER// /_}*) rvm_user_install_flag=1 ;;
  (*)                      rvm_user_install_flag=0 ;;
esac

install_rubies=()
install_gems=()
flags=()
forwarded_flags=()
# Parse CLI arguments.
while (( $# > 0 ))
do
  token="$1"
  shift
  case "$token" in

    --trace)
      set -o xtrace
      rvm_trace_flag=1
      flags+=( "$token" )
      forwarded_flags+=( "$token" )
      ;;

    --debug|--quiet-curl)
      flags+=( "$token" )
      forwarded_flags+=( "$token" )
      token=${token#--}
      token=${token//-/_}
      export "rvm_${token}_flag"=1
      printf "%b" "Turning on ${token/_/ } mode.\n"
      ;;

    --path)
      if [[ -n "${1:-}" ]]
      then
        rvm_path="$1"
        shift
      else
        fail "--path must be followed by a path."
      fi
      ;;

    --branch|branch) # Install RVM from a given branch
      if [[ -n "${1:-}" ]]
      then
        version="head"
        branch="$1"
        shift
      else
        fail "--branch must be followed by a branchname."
      fi
      ;;

    --user-install|--ignore-dotfiles)
      token=${token#--}
      token=${token//-/_}
      export "rvm_${token}_flag"=1
      printf "%b" "Turning on ${token/_/ } mode.\n"
      ;;

    --auto-dotfiles)
      flags+=( "$token" )
      export "rvm_auto_dotfiles_flag"=1
      printf "%b" "Turning on auto dotfiles mode.\n"
      ;;

    --auto)
      export "rvm_auto_dotfiles_flag"=1
      printf "%b" "Warning, --auto is deprecated in favor of --auto-dotfiles.\n"
      ;;

    --verify-downloads)
      if [[ -n "${1:-}" ]]
      then
        export rvm_verify_downloads_flag="$1"
        forwarded_flags+=( "$token" "$1" )
        shift
      else
        fail "--verify-downloads must be followed by level(0|1|2)."
      fi
      ;;

    --autolibs=*)
      flags+=( "$token" )
      export rvm_autolibs_flag="${token#--autolibs=}"
      forwarded_flags+=( "$token" )
      ;;

    --with-gems=*)
      flags+=( "$token" )
      export rvm_with_gems="${token#--with-gems=}"
      printf "%b" "Installing RVM with gems: ${rvm_with_gems}.\n"
      ;;

    --without-gems=*)
      flags+=( "$token" )
      export rvm_without_gems="${token#--without-gems=}"
      printf "%b" "Installing RVM without gems: ${rvm_without_gems}.\n"
      ;;

    --version|version)
      version="$1"
      shift
      ;;

    head)
      version="head"
      branch="master"
      ;;

    stable|master)
      version="head"
      branch="$token"
      ;;

    latest|latest-*|+([[:digit:]]).+([[:digit:]]).+([[:digit:]]))
      version="$token"
      ;;

    --ruby)
      install_rubies+=( ruby )
      ;;

    --ruby=*)
      token=${token#--ruby=}
      install_rubies+=( ${token//,/ } )
      ;;

    --rails)
      install_gems+=( rails )
      ;;

    --gems=*)
      token=${token#--gems=}
      install_gems+=( ${token//,/ } )
      ;;

    (--add-to-rvm-group)
      export rvm_add_users_to_rvm_group="$1"
      shift
      ;;

    help|usage)
      usage
      exit 0
      ;;
  *)
    usage
    exit 1
    ;;

  esac
done

case "$rvm_path" in
  *[[:space:]]*)
    printf "%b" "
It looks you are one of the happy *space* users(in home dir name),
RVM is not yet fully ready for it, use this trick to fix it:

    sudo mkdir -p /${USER// /_}.rvm
    sudo chown -R \"$USER:\" /${USER// /_}.rvm
    echo \"export rvm_path=/${USER// /_}.rvm\" >> \"$HOME/.rvmrc\"

and start installing again.

"
    exit 2
  ;;
  /usr/share/ruby-rvm)
    printf "%b" "
It looks you are one of the happy Ubuntu users,
RVM packaged by Ubuntu is old and broken,
follow this link for details how to fix:

  http://stackoverflow.com/a/9056395/497756

"
    [[ "${rvm_uses_broken_ubuntu_path:-no}" == "yes" ]] || exit 3
  ;;
esac

if (( ${#install_gems[@]} > 0 && ${#install_rubies[@]} == 0 ))
then
  install_rubies=( ruby )
fi

if (( ${#install_rubies[@]} > 0 ))
then
  echo "Please read and follow further instructions."
  echo "Press ENTER to continue."
  builtin read -n 1 -s -r anykey
fi

true "${version:=head}"

if [[ "$rvm_path" != /* ]]
then
  fail "The rvm install path must be fully qualified. Tried $rvm_path"
fi

rvm_src_path="$rvm_path/src"
rvm_archives_path="$rvm_path/archives"
rvm_releases_url="https://rvm.io/releases"

for dir in "$rvm_src_path" "$rvm_archives_path"
do
  if [[ ! -d "$dir" ]]
  then
    mkdir -p "$dir"
  fi
done

# Perform the actual installation, first we obtain the source using whichever
# means was specified, if any. Defaults to head.
case "${version}" in
  (head)
    echo "${branch}" > "$rvm_path/RELEASE"
    install_head ${branch:-master} || exit $?
    ;;

  (latest)
    echo "${version}" > "$rvm_path/RELEASE"
    install_release $(fetch_version "") || exit $?
    ;;

  (latest-minor)
    echo "${version}" > "$rvm_path/RELEASE"
    version="$(\cat "$rvm_path/VERSION")"
    install_release $(fetch_version "${version%.*}") || exit $?
    ;;

  (latest-*)
    echo "${version}" > "$rvm_path/RELEASE"
    install_release $(fetch_version "${version#latest-}") || exit $?
    ;;

  (+([[:digit:]]).+([[:digit:]]).+([[:digit:]])) # x.y.z
    echo "version" > "$rvm_path/RELEASE"
    install_release ${version} || exit $?
    ;;

  (*)
    fail "Something went wrong, unrecognized version '$version'"
    ;;
esac

# required flag - path to install
flags+=( --path "$rvm_path" )

chmod +x ./scripts/install
./scripts/install "${flags[@]}"

if (( ${#install_rubies[@]} > 0 ))
then
  (
    source ${rvm_scripts_path:-${rvm_path}/scripts}/rvm
    source ${rvm_scripts_path:-${rvm_path}/scripts}/version
    __rvm_version

    for _ruby in ${install_rubies[@]}
    do command rvm "${forwarded_flags[@]}" install ${_ruby} -j 2
    done
    # set the first one as default, skip rest
    for _ruby in ${install_rubies[@]}
    do
      rvm "${forwarded_flags[@]}" alias create default ${_ruby}
      break
    done

    for _gem in ${install_gems[@]}
    do rvm "${forwarded_flags[@]}" all do gem install ${_gem}
    done

    printf "%b" "
  * To start using RVM you need to run \`source $rvm_path/scripts/rvm\`
    in all your open shell windows, in rare cases you need to reopen all shell windows.
"

    if [[ "${install_gems[*]}" =~ "rails" ]]
    then
      printf "%b" "
  * To start using rails you need to run \`rails new <project_dir>\`.
"
    fi
  )
fi
