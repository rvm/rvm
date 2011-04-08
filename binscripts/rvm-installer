#!/usr/bin/env bash

log()  { printf "$*\n" ; return $? ;  }

fail() { log "\nERROR: $*\n" ; exit 1 ; }

usage()
{
  printf "

Usage

  rvm-installer [options] [action]

Options

  --branch <name>               - Install RVM head, from named branch
  --version <head|latest|x.y.z> - Install RVM version [head|latest|x.y.z]
  --trace                       - used to debug the installer script

Actions

  help - Display CLI help (this output)

"
}

fetch_version()
{
  version=$(curl -B "${rvm_releases_url}/latest-version.txt" 2>/dev/null)
}

fetch_md5()
{
  md5=$(curl -B "${rvm_releases_url}/rvm-${version}.tar.gz.md5" 2>/dev/null)
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
      archive_md5="$(md5sum "${archive}" | awk '{print $1}')"
      ;;
  esac

  [[ "$archive_md5" == "$md5" ]]

  return $?
}

install_release()
{
  archive="$rvm_archives_path/rvm-${version}.tar.gz"

  fetch_md5

  if [[ -s $archive ]] && ! md5_match ; then
    # Remove old installs, if they exist and have incorrect md5.
    [[ -f "$rvm_archives_path/rvm-${version}.tar.gz" ]] &&
      rm -f "$rvm_archives_path/rvm-${version}.tar.gz"
  fi

  curl -L "${rvm_releases_url}/rvm-${version}.tar.gz" -o "$archive"

  if ! md5_match "$archive" ; then
    fail "ERROR:

Archive package downloaded does not match it's calculated md5 checksum ${md5}:

  $rvm_archives_path/rvm-${version}.tar.gz

Retry the installation and/or check your networking setup.

Halting installation.
"
  fi

  tar zoxf "${rvm_archives_path}/rvm-${version}.tar.gz" -C "$rvm_src_path/"

  cd "$rvm_src_path/rvm-${version}"
}

install_head()
{
  local remote="origin"

  if [[ -d "${rvm_src_path}/rvm/.git" ]] ; then
    builtin cd "${rvm_src_path}/rvm/"

    if [[ -z "$(git branch | awk "/$branch$/")" ]] ; then
      if ! git checkout -b "$branch" --track "$remote/$branch" 2>/dev/null ; then
        fail "$remote $branch remote branch not found."
      fi
    elif [[ -z "$(git branch | awk "/\* $branch$/{print \$2}")" ]] ; then
      if ! git checkout $branch 2>/dev/null ; then
        fail "Unable to checkout $branch."
      fi
    fi

    git pull --rebase origin $branch
  else
    builtin cd "${rvm_src_path}"

    if ! git clone --depth 1 git://github.com/wayneeseguin/rvm.git ; then
      if !  git clone https://github.com/wayneeseguin/rvm.git ; then
        fail "Unable to clone the RVM repository, attempted both git:// and https://"
      fi
    fi
  fi

  builtin cd "${rvm_src_path}/rvm/"

  return 0
}

shopt -s extglob
set -o errtrace
set -o errexit

true ${rvm_ignore_rvmrc:=0}

if [[ $UID -eq 0 ]] ; then
  [[ $rvm_ignore_rvmrc -eq 0 && -s /etc/rvmrc ]] && source /etc/rvmrc
  true "${rvm_path:="/usr/local/rvm"}"
else
  [[ $rvm_ignore_rvmrc -eq 0 && -s "$HOME/.rvmrc" ]] && source "$HOME/.rvmrc"

  if [[ -z "${rvm_path:-}" || "${rvm_path}" = "/usr/local/rvm" ]] ; then
    rvm_path="$HOME/.rvm"
  fi
fi

# Parse CLI arguments.
while [[ $# -gt 0 ]] ; do
  token="$1" ; shift
  case "$token" in

    --path)
      if [[ -n "${1:-}" ]] ; then
        rvm_path="$1" ; shift
      else
        fail "--path must be followed by a path."
      fi
      ;;

    --trace)
      set -o xtrace
      export rvm_trace_flag=1
      ;;

    --branch) # Install RVM from a given branch
      if [[ -n "${1:-}" ]] ; then
        version="head"
        branch="$1" ; shift
      else
        fail "--branch must be followed by a branchname."
      fi
      ;;

    --version)
      case "$1" in
        +([[:digit:]]).+([[:digit:]]).+([[:digit:]]))
          version="$1" ; shift
          ;;
        lastest|stable)
          version="latest" ; shift
          ;;
        head|master)
          version="head" ; shift
          branch="master"
          ;;
        *)
          fail "--version must be followed by a vaild version number x.y.z"
          ;;
      esac
      ;;

    +([[:digit:]]).+([[:digit:]]).+([[:digit:]]))
      version="$token"
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

export PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "

rvm_src_path="$rvm_path/src"
rvm_archives_path="$rvm_path/archives"
rvm_releases_url="https://rvm.beginrescueend.com/releases"
rvm_prefix="$(dirname $rvm_path)/"

for dir in  "$rvm_src_path" "$rvm_archives_path" ; do
  [[ ! -d "$dir" ]] && mkdir -p "$dir/"
done

# Perform the actual installation, first we obtain the source using whichever
# means was specified, if any. Defaults to head.
case "${version}" in
  head)
    install_head
    ;;

  latest)
    fetch_version
    install_release
    ;;

  +([[:digit:]]).+([[:digit:]]).+([[:digit:]])) # x.y.z
    install_release
    ;;
  *)
    fail "Something went wrong, unrecognized version '$version'"
    ;;
esac

# No matter which one we are doing we install the same way, using the RVM
#   installer script.
chmod +x ./scripts/install

flags=""
[[ ${rvm_trace_flag:-0} -eq 1 ]] && flags="$flags --trace"
[[ ${rvm_debug_flag:-0} -eq 1 ]] && flags="$flags --debug"

# Now we yield to the RVM installer.
exec ./scripts/install ${flags} --prefix "$rvm_prefix" --path "$rvm_path"
