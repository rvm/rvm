#!/usr/bin/env bash

shopt -s extglob
PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
export PS4
set -o errtrace
set -o errexit

log()  { printf "%b\n" "$*" ; return $? ;  }

fail() { log "\nERROR: $*\n" ; exit 1 ; }

if [[ ! " ${rvm_tar_options:-} " =~ " --no-same-owner "  ]] && \
  tar --help | \grep -- --no-same-owner >/dev/null
then
  rvm_tar_options="${rvm_tar_options:-} --no-same-owner"
  rvm_tar_options="${rvm_tar_options## }"
fi

usage()
{
  printf "%b" "

Usage

  rvm-installer [options] [action]

Options

  --branch <name>               - Install RVM head, from named branch
  --version <head|latest|x.y.z> - Install RVM version [head|latest|x.y.z]
  --trace                       - used to debug the installer script

Actions

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

fetch_version()
{
  version=$(curl -s -B "${rvm_releases_url}/latest-version.txt" 2>/dev/null)
}

fetch_md5()
{
  md5=$(curl -s -B "${rvm_releases_url}/rvm-${version}.tar.gz.md5" 2>/dev/null)
}

md5_match()
{
  local archive="$1"

  case "$(uname)" in
    Darwin|FreeBSD)
      archive_md5="$(/sbin/md5 -q "${archive}")"
      ;;

    OpenBSD)
      archive_md5="$(/bin/md5 -q "${archive}")"
      ;;

    Linux|*)
      archive_md5="$(md5sum "${archive}")"
      archive_md5="${archive_md5%% *}"
      ;;
  esac

  if [[ "$archive_md5" == "$md5" ]]
  then
    return 0
  else
    return 1
  fi
}

install_release()
{
  local archive url

  archive="${rvm_archives_path}/rvm-${version}.tar.gz"
  url="${rvm_releases_url}/rvm-${version}.tar.gz"

  fetch_md5

  if [[ -s "${archive}" && -n "${md5}" ]] && ! md5_match "${archive}"
  then
    # Remove old installs, if they exist and have incorrect md5.
    if [[ -f "${archive}" ]]
    then
      rm -f "${archive}"
    fi
  fi

  if curl -L "${url}" -o "${archive}"
  then
    true
  else
    fail "Failed to download ${url} to ${archive} using 'curl', error code ($?)"
  fi

  if ! md5_match "$archive"
  then
    fail "ERROR:

Archive package downloaded does not match its calculated md5 checksum ${md5}:

  $rvm_archives_path/rvm-${version}.tar.gz

Retry the installation and/or check your networking setup.

Halting installation.
"
  fi

  if tar zxf "${archive}" -C "$rvm_src_path/" --no-same-owner
  then
    cd "$rvm_src_path/rvm-${version}"
  else
    fail "Failed to extract ${archive} to ${rvm_src_path}/,"\
      "tar command returned error code $?"
  fi
}

install_head()
{
  typeset _repo _name _branch _local_branch
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
      _repo=${1%/*}
      _branch=${1#*/}
      ;;
    (*)
      _repo=wayneeseguin
      _branch=$1
      ;;
  esac

  log "Downloading RVM from ${_repo} branch ${_branch}"
  if curl -L https://github.com/${_repo}/rvm/tarball/${_branch} -o ${rvm_archives_path}/${_repo}-rvm-${_branch}.tgz
  then
    true
  else
    typeset ret=$?
    case $ret in
      (60)
        log "
Could not download 'https://github.com/${_repo}/rvm/tarball/${_branch}'.
  Make sure your certificates are up to date as described above.
  To continue in insecure mode run 'echo insecure >> ~/.curlrc'.
"
        return 60
        ;;
      (*)
        log "
Could not download 'https://github.com/${_repo}/rvm/tarball/${_branch}'.
  curl returned status '$ret'.
"
        return 1
        ;;
    esac
  fi

  [[ -d "${rvm_src_path}/rvm" ]] || \mkdir -p "${rvm_src_path}/rvm"
  if ! builtin cd "${rvm_src_path}/rvm"
  then
    log "Could not change directory '${rvm_src_path}/rvm'."
    return 2
  fi

  rm -rf ${rvm_src_path}/rvm/*
  if ! tar xzf ${rvm_archives_path}/${_repo}-rvm-${_branch}.tgz ${rvm_tar_options:-}
  then
    log "Could not extract RVM sources."
    return 3
  fi

  if ! mv ${_repo}-rvm-*/* .
  then
    log "Could not move RVM sources path."
    return 4
  fi
  rm -rf ${_repo}-rvm-*
}

# Tracing, if asked for.
if [[ "$*" =~ --trace ]] || (( ${rvm_trace_flag:-0} > 0 ))
then
  set -o xtrace
  export rvm_trace_flag=1
fi

# Variable initialization, remove trailing slashes if they exist on HOME
true \
  ${rvm_trace_flag:=0} ${rvm_debug_flag:=0} ${rvm_user_install_flag:=0}\
  ${rvm_ignore_rvmrc:=0} HOME="${HOME%%+(\/)}"


if (( rvm_ignore_rvmrc == 0 ))
then
  for rvmrc in /etc/rvmrc "$HOME/.rvmrc"
  do
    if [[ -s "$rvmrc" ]]
    then
      if \grep '^\s*rvm .*$' "$rvmrc" >/dev/null 2>&1
      then
        printf "%b" "
Error: $rvmrc is for rvm settings only.
rvm CLI may NOT be called from within $rvmrc.
Skipping the loading of $rvmrc
"
        return 1
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
    rvm_path="/usr/local/rvm"
  else
    rvm_path="${HOME}/.rvm"
  fi
fi
export HOME rvm_path

# Parse CLI arguments.
while (( $# > 0 ))
do
  token="$1"
  shift
  case "$token" in

    --trace)
      set -o xtrace
      export rvm_trace_flag=1
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

    --branch) # Install RVM from a given branch
      if [[ -n "${1:-}" ]]
      then
        version="head"
        branch="$1"
        shift
      else
        fail "--branch must be followed by a branchname."
      fi
      ;;

    --user-install|--auto)
      token=${token#--}
      token=${token//-/_}
      export "rvm_${token}_flag"=1
      printf "%b" "Turning on ${token/_/ } mode.\n"
      ;;

    --version)
      case "$1" in
        +([[:digit:]]).+([[:digit:]]).+([[:digit:]]))
          version="$1"
          ;;
        latest)
          version="latest"
          ;;
        stable)
          version="head"
          branch="stable"
          ;;
        head|master)
          version="head"
          branch="master"
          ;;
        *)
          fail "--version must be followed by a vaild version number x.y.z"
          ;;
      esac
      shift
      ;;

    +([[:digit:]]).+([[:digit:]]).+([[:digit:]]))
      version="$token"
      ;;

    stable)
      version="head"
      branch="stable"
      ;;

    head|master)
      version="head"
      branch="master"
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

true "${version:=head}"

if [[ "$rvm_path" != /* ]]
then
  fail "The rvm install path must be fully qualified. Tried $rvm_path"
fi

rvm_src_path="$rvm_path/src"
rvm_archives_path="$rvm_path/archives"
rvm_releases_url="https://rvm.beginrescueend.com/releases"

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
    install_head ${branch:-master} || exit $?
    ;;

  (latest)
    fetch_version
    install_release
    ;;

  (+([[:digit:]]).+([[:digit:]]).+([[:digit:]])) # x.y.z
    install_release
    ;;
  (*)
    fail "Something went wrong, unrecognized version '$version'"
    ;;
esac

# No matter which one we are doing we install the same way, using the RVM
#   installer script.
flags=()
if (( rvm_trace_flag == 1 ))
then flags+=("--trace")
fi

if (( rvm_debug_flag == 1 ))
then flags+=("--debug")
fi

if (( rvm_auto_flag == 1 ))
then flags+=("--auto")
fi

chmod +x ./scripts/install

# Now we run the RVM installer.
./scripts/install ${flags[*]} --path "$rvm_path"
