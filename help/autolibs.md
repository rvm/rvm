# Autolibs

## Synopsis

`rvm autolibs <flag>` __or__ `rvm install --autolibs=<flag>` __or__ `rvm get [type] --autolibs=<flag>`

## Description

Autolibs is a feature built into RVM to allow you to automatically install dependencies on your system.  These dependencies are typically things like OpenSSL, YAML and others. You can also disable autolibs completely or do things in-between "take care of it all" and "do nothing at all".

## Difference between `--autolibs` and `autolibs`

Some people might get confused at the difference between `--autolibs` and `autolibs` and even the difference between `--autolibs` when installing rubies (`rvm install [ruby] --autolibs`) and `--autolibs` when installing `rvm` (`rvm get [type] --autolibs`) but worry not, it's simple to remember.

* `rvm get [type] --autolibs=<flag>` is like `rvm autolibs <flag>`.
* `rvm autolibs <flag>` is permanent.
* `rvm install [ruby] --autolibs=<flag>` overrides `rvm autolibs <flag>` temporarily.

## Modes

* `0`, `disable`, `disabled` - Do not do anything.
* `1`, `read`, `read-only` - Use available libs, ignore missing.
* `2`, `fail`, `read-fail` - Use libs, fail if some are missing.
* `3`, `packages`, `install-packages`, - Use libs, install missing libs.
* `4`, `enable`, `enabled` - Install missing package manager (only OSX, on Linux it's like 3).

## Letting RVM take care of it all (4)

__*This only applies to OS X users, for non OS X users this will behave like 3*__

RVM can take care of everything for you as an OS X user, this means it will install Homebrew in the `.rvm` folder and manage all it's own dependencies. Typically this would be the best option for new users who do not have their own package manager installed and do not know how to compile their own software.

Enabling 4:
```
rvm autolibs enable
```

## Letting RVM take care of packages (3)

RVM can also be set to only check for a package manager and install any packages you might need or that might need to be updated.  This is the recommended option for users who do not want to deal with the task of managing their own dependencies.  This option works for both Linux and OS X users.

Enabling 3:
```
rvm autolibs packages
```

Using 3 only once:
```
rvm install --autolibs=packages
```

You can also optionally enforce a package manager if you are using smf or on OS X by issuing one of the following instead of 4: `brew, homebrew, osx_brew, port, macports, osx_port, fink, osx_fink`

## Other options (2, 1 and 0).

Autolibs also has three other options and these options are 2, which will read packages and fail if a package is missing, 1, which will read packages and continue but warn and 0 which will completely disable autolibs.

## Other modes

* `reset` - Reset RVM back to default mode.
* `show` - Display your current mode.
* `help` - Display basic mode descriptions.
* `status` - Display detailed information about your mode.

## Additional modes

* `brew`, `homebrew`, `osx_brew` - Like 4, enforce Homebrew.
* `fink`, `osx_fink` - Like 4, enforces Fink.
* `smf` - Like 4, enforce SM Framework.
* `port`, `macports`, `osx_port` - Like 4, enforce MacPorts.
