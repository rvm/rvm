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

## Other options

* `reset`  - Reset RVM back to default mode.
* `status` - Display detailed information about your mode.
* `show`   - Display your current mode.
* `help`   - Display basic mode descriptions.

## Modes explained

The default mode is `enabled`, below is explanation of the modes,
where most useful will be `read-fail` in case user has no `sudo` access.

## Letting RVM take care of it all (4)

RVM can take care of everything for user, this means it will detect existing package manager and install one if none is available.
Typically this would be the best option for new users who do not have their own package manager installed and do not know how to compile their own software.

Enabling 4:

    rvm autolibs enable

Most of the systems ships with a package manager so the `enable` mode is the same as `packages`.
Unfortunately on OSX there is not package manger provided so RVM has to detect one of existing user efforts,
The detection is in order: `homebrew`, `macports`, `smf`, `fink` if none of them is available then RVM will install `macports`.

You can also optionally enforce a package manager by using one of the following instead of `enable`:

`macports`, `homebrew`, `fink`, `smf` (SM Framework) or `rvm_pkg` (the old `rvm pkg`), like:

    rvm autolibs homebrew

Or with the installer including homebrew, ruby and rails:

    \curl -L https://get.rvm.io | bash -s stable --autolibs=homebrew --rails


## Letting RVM take care of packages (3)

RVM can also be set to only check for a package manager and install any packages you might need or that might need to be updated.  This is the recommended option for users who do not want to deal with the task of managing their own dependencies.  This option works for both Linux and OS X users.

Enabling 3:

    rvm autolibs packages

Using 3 only once:

    rvm install --autolibs=packages <ruby>

## Tell RVM to fail when something is missing (2)

    rvm autolibs read-fail


## Tell RVM to try to use existing dependencies, but do not fail if something is missing (1)

    rvm autolibs read-only

## Avoid any extra actions or configuration (0)

    rvm autolibs disable

## Examples

Install RVM with Ruby and Ruby on Rails with all required libraries:

    \curl -L https://get.rvm.io | bash -s stable --rails
