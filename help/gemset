
Usage:

    rvm gemset [action]
    rvm --force gemset [action]

Actions:

  import,export,create,copy,rename,empty,delete,name,dir,list,list_all,gemdir,install,pristine,clear,use,update,unpack,globalcache

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
