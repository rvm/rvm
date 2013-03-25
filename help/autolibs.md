# Autolibs

Support for automatic dependency handling


## Usage

    rvm autolibs [disable|read-only|read-fail|packages|enable] # change current mode
    rvm autolibs [osx_brew|osx_port|osx_fink|smf] # enable and set default package manager
    rvm autolibs reset  # reset to default mode (read-fail)
    rvm autolibs show   # show current mode
    rvm autolibs status # show more details about current mode
    rvm autolibs [help] # show this help


## Allowed modes

- `0`, `disable`, `disabled`          - Limit RVM automation as much as possible.
- `1`, `read`, `read-only`            - Allow RVM to use package manager if found but do not install or fail if dependencies are missing.
- `2`, `fail`, `read-fail`            - Allow RVM to use package manager if found, fail if dependencies are missing. This is **default**.
- `3`, `packages`, `install-packages` - Allow RVM to use package manager if found, install missing dependencies.
- `4`, `enable`, `enabled`            - Allow RVM to use package manager if found, install missing dependencies, install package manager (only OSX).
- `brew`, `homebrew`, `osx_brew`      - Like `4` but forces use of Homebrew.
- `port`, `macports`, `osx_port`      - Like `4` but forces use of MacPorts.
- `fink`, `osx_fink`                  - Like `4` but forces use of Fink.
- `smf`                               - Like `4` but forces use of SM Framework.
