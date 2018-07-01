  * If you wish to disable the project .rvmrc file functionality, set
    rvm_project_rvmrc=0 in either /etc/rvmrc or ~/.rvmrc.
    then log out and back in.

  * after_use and after_cd hook now supports multiple files with after_*_*
    the custom hooks can be easily turned on/off by:
      chmod +x $rvm_path/hooks/after_cd_[hook_name]
      chmod -x $rvm_path/hooks/after_use_[hook_name]

  * If your shell exits on entering a directory with freshly checked out sources
    you should update .rvmrc file, and replace any `exit ` with `return `.

  * In case you have some old RVM files/rubies in '/usr/local/bin' or '$HOME/bin' feel free to remove them,
    they were copied there because of bug in path detection.

  * Zsh 4.3.15 is buggy, be careful with it, it can break RVM, especially multiuser installations,
    You should consider downgrading Zsh to 4.3.12 which has proven to work more reliable with RVM.

  * Optionally you can run \`rvm tools rvm-env ruby bash\` which will generate
    shebang wrappers for easier selecting ruby in scripts.

  * If you wish to get more default(global) gems installed, install RVM with this flag: --with-gems="pry vagrant"
    this option is remembered, it's enough to use it once.

  * Binary rubies are installed by default if available, you can read about it in help:
      rvm help install
      rvm help mount

  * RVM comes with a set of default gems including 'bundler', 'rake', 'rubygems-bundler' and 'rvm' gems;
    if you do not wish to get these gems, install RVM with this flag: --without-gems="rvm rubygems-bundler"
    this option is remembered, it's enough to use it once.

  * RVM will try to automatically use available package manager, might require `sudo`,
    read more about it in `rvm help autolibs`

  * The default umask for multi-user installation got extended to `umask u=rwx,g=rwx,o=rx`,
    comment it out to avoid automatic updates.

  * If you encounter any issues with a ruby 'X' your best bet is to:
      rvm get head && rvm reinstall X --debug

  * RVM will run 'rvm requirements' by default, to disable run:
      echo rvm_autolibs_flag=0 >> ~/.rvmrc

  * RVM 1.20.12 removes the automated --progress-bar from curl options,
    if you liked this then you can restore this behavior with:

      echo progress-bar >> ~/.curlrc

  * RVM will set first installed ruby as default and use it if run as function.
    To avoid this behavior either use full path to rvm binary or prefix it with `command `.

  * To update RVM loading code run 'rvm get ... --auto-dotfiles'

  * RVM 1.20 changes default behavior of Autolibs to Enabled - if you prefer the 1.19 behavior
    then run "rvm autolibs read-fail", read more details: rvm help autolibs

  * RVM 1.24 changes default package manager on OSX to Homebrew,
    use `rvm autolibs macports` if you prefer Macports.

  * RVM 1.24 changes default `--verify-downloads` flag to `1` you can get the paranoid mode again with:

      echo rvm_verify_downloads_flag=0 >> ~/.rvmrc

  * RVM 1.25 disables default pollution of rvm_path/bin, you still can generate the links using:

      rvm wrapper ruby-name           # or for default:
      rvm wrapper default --no-prefix

  * RVM 1.25.11 'rvm remove' will by default remove gems, to remove only ruby use 'rvm uninstall'

  * RVM 1.30 simplifies behavior of 'rvm wrapper' subcommand
