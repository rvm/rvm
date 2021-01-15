#!/usr/bin/env bash

calculate_last()
{
  git checkout stable
  last_release="$( git tag --list --sort=v:refname | tail -n 1 )"
}

go_to_temp()
{
  mkdir -p ~/tmp/${last_release}/$1/unpacked
  cd  ~/tmp/${last_release}/$1
  echo -e "\n------------\nWorking dir: $PWD"
}

download_from_github()
{
  [[ -e ${last_release}.tar.gz ]] ||
  curl -OL https://github.com/rvm/rvm/archive/${last_release}.tar.gz
}

download_from_bitbucket()
{
  [[ -e ${last_release}.tar.gz ]] ||
  curl -OL https://bitbucket.org/mpapis/rvm/get/${last_release}.tar.gz
}

unpack_package()
{
  tar -xzf ${last_release}.tar.gz --strip-components=1 -C unpacked
}

compare_package_with_stable()
{
  diff -ur -x .git -x rvm-test -x .idea "$rvm_project_path" $PWD/unpacked ||
  {
    typeset __result=$?
    echo "found differences (result:$__result), skipping signature generation"
    return $__result
  }
}

sign_release()
{
  gpg2 --armor --detach-sig ${last_release}.tar.gz
}

remove_extra_files()
{
  rm -rf ${last_release}.tar.gz unpacked
}

upload_github()
{
  echo "Upload ${last_release}.tar.gz.asc to: https://github.com/rvm/rvm/releases/new?tag=${last_release}"
}

upload_bitbucket()
{
  echo "Upload ${last_release}.tar.gz.asc to: https://bitbucket.org/mpapis/rvm/downloads"
}

back_to_rvm_master()
{
  echo -e "\n------------"
  cd "$rvm_project_path"
  git checkout master
}

main()
{
  typeset last_release rvm_project_path

  rvm_project_path="$PWD"
  calculate_last
  for current in github bitbucket
  do
    go_to_temp ${current}
    download_from_${current}
    unpack_package
    compare_package_with_stable || continue
    sign_release
    remove_extra_files
    upload_${current}
  done
  back_to_rvm_master
}

main
