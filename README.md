Stable [![Stable Build Status](https://travis-ci.org/rvm/rvm.svg?branch=stable)](https://travis-ci.org/rvm/rvm/branches)
[![Funds Raised](https://api.bountysource.com/badge/team?team_id=506&style=raised)](https://www.bountysource.com/teams/rvm?utm_source=RVM&utm_medium=shield&utm_campaign=raised)
&bull;
Master [![Master Build Status](https://travis-ci.org/rvm/rvm.svg?branch=master)](https://travis-ci.org/rvm/rvm/branches)

# What's RVM

RVM is the Ruby enVironment Manager (rvm). It manages Ruby application environments and enables switching between them.

Homepage and more info: https://rvm.io/

## Installation

`curl -L https://get.rvm.io | bash -s stable --autolibs=enabled [--ruby] [--rails] [--trace]`

* `stable`     - install stable RVM, good for servers
* `--autolibs` - enable or disable autolibs - https://rvm.io/rvm/autolibs
* `--rails`    - install gem `rails` into default gemset (also installs ruby)        
* `--ruby`     - additionally install latest ruby version (MRI)                     
* `--trace`    - print trace of the installation

More details here: https://rvm.io/rvm/install/

## Usage

`rvm FLAGS OPTIONS ACTION [IMPLEMENTATION[,IMPLEMENTATION[,...]]`

### Flags

* `--32`              - option for installing 32-bit rubies
* `--64`              - option for installing 64-bit rubies (default behavior)
* `--debug`           - toggle debug mode on for very verbose output
* `--default`         - with `rvm use X`, sets the default ruby for new shells to `X`
* `--disable-binary`  - install from source instead of using binaries
* `--docs`            - with `install`, attempt to generate ri after installation
* `--force`           - force install, removes old install & source before install
* `--gems`            - with `uninstall`/`remove` removes gems with the interpreter
* `--latest`          - with gemset `--dump` skips version strings for latest gem
* `--quiet-curl`      - makes `curl` silent when fetching data
* `--reconfigure`     - force `./configure` on install even if `Makefile` already exists
* `--skip-gemsets`    - with `install`, skip the installation of default gemsets
* `--summary`         - used with `rubydo` to print out a summary of the commands run
* `--trace`           - toggle trace mode on to see EVERYTHING rvm is doing

### Options

* `--archive`           - used to set the `archive_flag`, use with `remove` to remove archive
* `--bin`               - path for binaries to be placed (`~/.rvm/bin/.`)
* `--gems`              - used to set the `gems_flag`, use with `remove` to remove gems
* `--nice`              - process niceness (for slow computers, default `0`)
* `--patch`             - with MRI Rubies you may specify one or more full paths to patches. Multiple patches should be comma separated `--patch a.patch[%prefix],b.patch`. `%prefix` is an optional argument, which will be bypassed to the `-p` argument of the `patch` command and should be separated from patch file name with the `%` symbol.
* `--ree-options`       - options passed directly to ree's `./installer` on the command line
* `--with-rubies`       - specifies a string for rvm to attempt to expand for set operations
* `-C` | `--configure`  - custom configure options - multiple options can be specified, separated with comma.
* `-e`                  - execute code from the command line
* `-l` | `--level`      - patch level to use with rvm `use`/`install`
* `-S`                  - specify a script file to attempt to load and run (`rubydo`)
* `-v` | `--version`    - display rvm version loaded for current shell

### Actions

*Note:* for most actions `rvm help action-name` may provide more information.

* **`usage`**         - show this usage information
* `alias`           - lets you set shortcut strings for convenience with `rvm use` tasks
* `autolibs`        - controls settings for automatically installing dependencies
* `cleanup`         - lets you remove stale source folders / archives and other miscellaneous data associated with rvm
* `config-get`      - display values for `RbConfig::CONFIG` variables
* `cron`            - manages setup for using ruby in cron
* `current`         - print the current ruby version and the name of any gemset being used
* `debug`           - show info plus additional information for common issues
* `disk-usage`      - tells you how much disk space rvm install is using
* `do`              - runs an arbitrary command against specified and/or all rubies
* `docs`            - tools to make installing ri and rdoc documentation easier
* `export`          - temporarily set an environment variable in the current shell
* `fetch`           - performs an archive / src fetch only of the selected ruby
* `fix-permissions` - repairs broken permissions (e.g. by sudo or chef)
* `gemdir`          - display the path to the current gem directory (`GEM_HOME`)
* `gemset`          - gemsets - https://rvm.io/gemsets/
* `get`             - `{head,stable,branch}` upgrades rvm to latest head, stable or branched version
* `group`           - tools for managing groups in multiuser installations
* `implode`         - removes the rvm installation completely. This means everything in `$rvm_path` (`~/.rvm` || `/usr/local/rvm`). This does not touch your profiles. However, this means that you must manually clean up your profiles and remove the lines which source RVM
* `info`            - show the environment information for current ruby
* `install`         - install one or many ruby versions. See also: https://rvm.io/rubies/installing/
* `list`            - show currently installed rubies, interactive output - https://rvm.io/rubies/list/
* `migrate`         - lets you migrate all gemsets from one ruby to another
* `mount`           - install rubies from external locations
* `notes`           - display notes with operating system specifics
* `osx-ssl-certs`   - helps update certificates for OpenSSL installed by rvm on OSX
* `patchset`        - tools related to managing ruby patchsets
* `pkg`             - install a dependency package `{readline,iconv,zlib,openssl}` - https://rvm.io/packages/
* `reinstall`       - reinstall ruby and runs `gem pristine` on all gems. Make sure to read output. Use `all` for all rubies
* `reload`          - reload rvm source itself (useful after changing rvm source).
* `remove`          - uninstall one or many ruby versions and remove their sources
* `repair`          - lets you repair parts of your environment e.g. wrappers, env files and similar files (e.g. general maintenance)
* `requirements`    - installs additional OS specific dependencies/requirements for building various rubies. Usually run by install
* `reset`           - remove current and stored default & system settings
* `rubygems`        - switches the installed version of rubygems for the current ruby
* `rvmrc`           - tools related to managing `.rvmrc` trust and loading
* `snapshot`        - lets you backup / restore an rvm installation in a lightweight manner
* `tools`           - provides general information about the ruby environment, primarily useful when scripting rvm
* `unexport`        - undo changes made to the environment by `rvm export`
* `uninstall`       - uninstall one or many ruby versions, keeping their sources
* `upgrade`         - lets you upgrade from one version of a ruby to another, including migrating your gemsets semi-automatically
* `use`             - setup current shell to use a specific ruby version
* `user`            - tools for managing RVM mixed mode in multiuser installations
* `version`         - show the rvm version installed in `rvm_path`
* `wrapper`         - generates a set of wrapper executables for a given ruby with the specified ruby and gemset combination. Used under the hood for passenger support and the like

### Implementations

* **`ruby`**     - MRI/YARV Ruby (The Gold Standard)
* `default`    - use the default ruby (or the system ruby if a default hasn't been set) - https://rvm.io/rubies/default/
* `ironruby`   - IronRuby, NOT supported yet. Looking for volunteers to help.
* `jruby`      - JRuby - Ruby interpreter on the Java Virtual Machine.
* `macruby`    - MacRuby, insanely fast, can make real apps (Mac OS X Only).
* `maglev`     - GemStone Ruby, awesome persistent ruby object store.
* `rbx`        - Rubinius
* `system`     - use the system ruby (eg. pre-rvm state)

Historical implementations which you can still install with RVM, but are not anymore developed and supported by their authors:

* `ree`        - Ruby Enterprise Edition - MRI Ruby with several custom patches for performance, stability, and memory

## Contributing

Any and all contributions offered in any form, past present or future, to the
RVM project are understood to be in complete agreement and acceptance with the
Apache License v2.0.

## License

Copyright (c) 2009-2011 Wayne E. Seguin
Copyright (c) 2011-2016 Michal Papis

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
