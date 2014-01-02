From source installation of required libraries for rubies, it is automatically triggered by:

    rvm autolibs rvm_pkg

You should not have to use it manually but just in case:

Usage:

    rvm pkg {install,uninstall} {readline,iconv,curl,openssl,zlib,autoconf,ncurses,pkgconfig,gettext,glib,mono,llvm,libxml2,libxslt,libyaml,epel}
    rvm pkg remove # to start fresh

`ree_dependencies` installs `zlib`, `ncurses`, `readline`, `openssl` and `iconv` in this order.
