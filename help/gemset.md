
Usage:

    rvm gemset [action]
    rvm --force gemset [action]

Actions:

    copy, create, delete, dir, empty, export, gemdir, globalcache, import, install, list, list_all, name, pristine, rename, unpack, update, use

Description:

  Commands for working with and manipulating gemsets within RVM.

  Any command is run in context of current ruby/gemset; call 'rvm current' to find out which is currently used.

  Note that 'system' supports only exporting/importing gems.

Rejection:

  If you do not want to use gemsets and want to ignore them you can use
  command line flag `--ignore-gemsets`:

    rvm use 1.9.3@my_project --ignore-gemsets

  it will ignore @my_project and @global -  only default gemset will be set.

  It can be persisted with:

    echo "export rvm_ignore_gemsets_flag=1" >> ~/.rvmrc
