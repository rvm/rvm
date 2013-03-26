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

## Letting RVM take care of it all (4)

__*This only applies to OS X users, for non OS X users this will behave like 3*__

RVM can take care of everything for you as an OS X user, this means it will install Homebrew in the `.rvm` folder and manage all it's own dependencies. Typically this would be the best option for new users who do not have their own package manager installed and do not know how to compile their own software.



Enabling 4:
```
rvm autolibs 4
```

## Letting RVM take care of packages (3)

RVM can also be set to only check for a package manager and install any packages you might need or that might need to be updated.  This is the recommended option for users who do not want to deal with the task of managing their own dependencies.  This option works for both Linux and OS X users.

Enabling 3:
```
rvm autolibs 3
```

Using 3 only once:
```
rvm install --autolibs=3
```

You can also optionally enforce a package manager if you are using smf or on OS X by issuing one of the following instead of 4: `brew, homebrew, osx_brew, port, macports, osx_port, fink, osx_fink`

## Other options (2, 1 and 0).

Autolibs also has three other options and these options are 2, which will read packages and fail if a package is missing, 1, which will read packages and continue but warn and 0 which will completely disable autolibs.

## Other modes

* `reset` &nbsp;=>&nbsp; Reset RVM back to default mode.
* `show` &nbsp;=>&nbsp; Display your current mode.
* `help` &nbsp;=>&nbsp; Display basic mode descriptions.
* `status` &nbsp;=>&nbsp; Display detailed information about your mode.

## Modes

* `0`, `disable`, `disabled` &nbsp;=>&nbsp; Disable autolibs.
* `1`, `read`, `read-only` &nbsp;=>&nbsp; Do not fail if missing packages.
* `2`, `fail`, `read-fail` &nbsp;=>&nbsp; Fail if missing packages.
* `3`, `packages`, `install-packages` &nbsp;=>&nbsp; Install missing packages.
* `4`, `enable`, `enabled` &nbsp;=>&nbsp; Install packages and homebrew if missing.

## Additional modes

* `brew`, `homebrew`, `osx_brew` &nbsp;=>&nbsp; Like 4, enforce Homebrew.
* `fink`, `osx_fink` &nbsp;=>&nbsp; Like 4, enforces Fink.
* `smf` &nbsp;=>&nbsp; Like 4, enforce SM Framework.
* `port`, `macports`, `osx_port` &nbsp;=>&nbsp; Like 4, enforce MacPorts.
