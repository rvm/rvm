Stable
<a href="https://travis-ci.org/rvm/rvm/branches"><img src="https://travis-ci.org/rvm/rvm.svg?branch=stable" align="center"></a>
<a href="https://www.bountysource.com/teams/rvm?utm_source=RVM&utm_medium=shield&utm_campaign=raised"><img src="https://api.bountysource.com/badge/team?team_id=506&style=raised" align="center"></a>
&nbsp;&nbsp;&nbsp;&nbsp;
Master
<a href="https://travis-ci.org/rvm/rvm/branches"><img src="https://travis-ci.org/rvm/rvm.svg?branch=master" align="center"></a>

# What's RVM

RVM is the acronym of Ruby enVironment Manager. It manages Ruby application environments and enables switching between them.

Homepage and more info: https://rvm.io/

## Installing RVM

### Ubuntu

RVM have dedicated Ubuntu package, so please follow instructions posted here: https://github.com/rvm/ubuntu_rvm
 
If you need a different (newer) version of RVM, after installing base version of RVM check the [Upgrading](#upgrading) section below. 

### Any other operating system

Make sure you have following required packages installed:

* `curl`

And then run:

`\curl -sSL https://get.rvm.io | bash -s stable`

### Additional installation options

Additional installation options and details about the installation process are described here: https://rvm.io/rvm/install

## Upgrading RVM

You can upgrade RVM any time by running:
 
`rvm get VERSION`

Where `VERSION` should be replaced by one of the following values:

* `stable`              - latest stable RVM (good for servers)
* `master`              - latest RVM (might not be stable)
* `branch /path/branch` - branched version of RVM (for testing new features or bug fixes)

Additional upgrading options are described here: https://rvm.io/rvm/upgrading

## Basic RVM usage

Basic RVM usage scenarios include installing and switching between different ruby versions.

### Installing ruby

To install ruby you have to call `rvm install INTERPRETER[-VERSION] OPTIONS` 

When no version specified, RVM will install latest stable version or selected interpreter. If you omit to specify interpreter, RVM will assume
that you wanted to install MRI ruby. Following examples would have exactly the same effect:    

```
rvm install ruby-2.3.1
rvm install ruby-2.3
rvm install 2.3.1
rvm install 2.3
```

Passing additional `--default` option makes selected ruby your default. 

We currently supported following ruby interpreters:

* `ruby`       - MRI ruby (The Gold Standard)
* `ironruby`   - a .NET ruby
* `jruby`      - Java implementation of the ruby
* `macruby`    - implementation of ruby 1.9 directly on top of macOS core technologies 
* `maglev`     - 64-bit implementation on top of VMware's GemStone
* `mruby`      - lightweight ruby
* `opal`       - ruby to JavaScript compiler
* `rbx`        - Rubinius - a next generation virtual machine VM for ruby
* `topaz`      - high performance ruby, written in RPython

Historical interpreters which you can still install with RVM, but are not anymore developed and supported by their authors:

* `ree`        - Ruby Enterprise Edition - MRI Ruby with several custom patches for performance, stability, and memory

### Switching between ruby versions

To switch between ruby versions you should call

`rvm use INTERPRETER[-VERSION]`

Same rules and options apply as for `install` command with two special _interpreters_. 

* `default`    - [default](https://rvm.io/rubies/default/) ruby (or the system ruby if a default hasn't been set)
* `system`     - system ruby (state before RVM was installed)

Additionally you might want list your preferred ruby version in `.ruby-version` file stored in your project folder. This would cause automatic switch to selected ruby whenever you enter the folder.  

### Other RVM commands

RVM comes bundled with many different tools for managing your ruby environment. More detailed information about every commands listed below can be read after executing `rvm help COMMAND` or browsing documentation on RVM homepage https://rvm.io/.

#### Installation

* `implode`              - removes the rvm installation completely. This means everything in `$rvm_path` (`~/.rvm` || `/usr/local/rvm`). This does not touch your profiles. However, this means that you must manually clean up your profiles and remove the lines which source RVM
* `install`              - [install](https://rvm.io/rubies/installing/) one or many ruby versions
* `list`                 - show currently installed rubies, interactive output - https://rvm.io/rubies/list/
* `mount`                - install rubies from external locations
* `patchset`             - tools related to managing ruby patchsets
* `pkg`                  - install a dependency package `{readline,iconv,zlib,openssl}` - https://rvm.io/packages/
* `reinstall`            - reinstall ruby and runs `gem pristine` on all gems. Make sure to read output. Use `all` for all rubies
* `reload`               - reload rvm source itself (useful after changing rvm source).
* `remove`               - uninstall one or many ruby versions and remove their sources
* `requirements`         - installs additional OS specific dependencies/requirements for building various rubies (by default run by `install`)
* `reset`                - remove current and stored default & system settings
* `snapshot`             - lets you backup / restore an rvm installation in a lightweight manner
* `uninstall`            - uninstall one or many ruby versions, keeping their sources
* `upgrade`              - lets you upgrade from one version of a ruby to another, including migrating your gemsets semi-automatically

#### Running different ruby versions

* `do`                   - runs an arbitrary command against specified and/or all rubies
* `use`                  - setup current shell to use a specific ruby version

#### Managing gemsets

* `gemset`               - manage [gemsets](https://rvm.io/gemsets/) 
* `migrate`              - lets you migrate all gemsets from one ruby to another

#### Configuration

* `alias`                - define aliases for `rvm use`
* `autolibs`             - control settings for installing dependencies automatically
* `current`              - print the current ruby version and the name of any gemset being used
* `gemdir`               - display the path to the current gem directory (`GEM_HOME`)
* `group`                - tools for managing groups in multiuser installations
* `rvmrc`                - tools related to managing `.rvmrc` trust and loading
* `wrapper`              - generates a set of wrapper executables for a given ruby with the specified ruby and gemset combination. Used under the hood for passenger support and the like

#### Maintenance

* `cleanup`              - remove stale source folders / archives and other miscellaneous data associated with rvm
* `cron`                 - manage setup for using ruby in cron
* `disk-usage`           - display disk space occupied by RVM
* `docs`                 - tools to make installing ri and rdoc documentation easier
* `fetch`                - download binary or sources for selected ruby version
* `get`                  - upgrades RVM to latest head, stable or branched version
* `osx-ssl-certs`        - helps update certificates for OpenSSL installed by rvm on OSX

#### Troubleshooting

* `config-get`           - display values for `RbConfig::CONFIG` variables
* `debug`                - show additional information helping to discover common issues
* `export`               - temporarily set an environment variable in the current shell
* `fix-permissions`      - repairs broken permissions
* `repair`               - lets you repair parts of your environment e.g. wrappers, env files and similar (e.g. general maintenance)
* `rubygems`             - switches the installed version of rubygems for the current ruby
* `tools`                - provides general information about the ruby environment, primarily useful when scripting rvm
* `unexport`             - undo changes made to the environment by `rvm export`
* `user`                 - tools for managing RVM mixed mode in multiuser installations

#### Information and documentation

* `info`                 - show the environment information for current ruby
* `notes`                - display notes with operating system specifics
* `usage`                - list available commands and their usage info (content of this README)
* `version`              - display rvm version (equal to `rvm -v`) 

### Additional global options

* `--debug`           - toggle debug mode on for very verbose output
* `--trace`           - toggle trace mode on to see EVERYTHING rvm is doing
* `--nice`            - process niceness (increase the value on slow computers, default `0`)
* `-v` | `--version`  - display rvm version loaded for current shell


## Reporting issues

Here at RVM we get a high amount of bug reports, and often they are connected 
with specific environment settings which might be hard for us to replicate. 
That's why we would kindly ask you to follow the steps below so we can maximize 
our time helping you and minimize the time requesting more information.

### Check documentation

We know, you hear this over and over and be rest assured we are working hard to improve the
usability of https://rvm.io but we must always ask that you first please check the documentation
if you are requesting a feature or if you are not sure if you did it right.

### Try again with latest RVM

We try to release a new RVM as soon as we feel that we achieved certain stability. This might take
a while and it could be the case that your issue has been already resolved in our development branch.
Please get the latest RVM and try again:

`rvm get master`

### File an issue

If the documentation is not clear, an error message is not clear or you are stuck with the problem,
please do file a bug.

When in doubt as to whether your issue might relate to another, simply file a new bug, and
we will mark it as duplicate if it needs to be.  It's always better to file a new ticket and
let us sort it out than to accidentally add noise to another ticket.

For filing issues, we have prepared a template for you to use. Please try to fill all sections as best as you can.
Always make sure to split up each command and its output into its own fenced code block. 
If the output is long, please put it in a separate [gist](https://gist.github.com). 
Otherwise it's hard for us to process all the information and respond quickly.

Note that if there is a lot of `debug` or `trace` output you can redirect it to a file with the `>` 
character like `rvm [command] > output.txt`.

## Contributing

You are very warmly welcome to help. Please follow our [contribution guidelines](CONTRIBUTING.md) 

Any and all contributions offered in any form, past present or future are understood to be in complete agreement and acceptance with the [Apache License](LICENSE) v2.0.

## License

Copyright (C) Michal Papis (2011-2017), Piotr Kuczynski (2016-2017), Wayne E. Seguin (2009-2011) 

Licensed under the [Apache License](LICENSE), Version 2.0
