Stable
<a href="https://travis-ci.org/rvm/rvm/branches"><img src="https://travis-ci.org/rvm/rvm.svg?branch=stable" align="center"></a>
<a href="https://www.bountysource.com/teams/rvm?utm_source=RVM&utm_medium=shield&utm_campaign=raised"><img src="https://api.bountysource.com/badge/team?team_id=506&style=raised" align="center"></a>
&nbsp;&nbsp;&nbsp;&nbsp;
Master
<a href="https://travis-ci.org/rvm/rvm/branches"><img src="https://travis-ci.org/rvm/rvm.svg?branch=master" align="center"></a>

# What's RVM

RVM is the acronym of Ruby enVironment Manager. It manages Ruby application environments and enables switching between them.

Homepage and more info at [https://rvm.io](https://rvm.io)

## Table of Contents

- [Installing RVM](#installing-rvm)
  - [Ubuntu](#ubuntu)
  - [Any other operating system](#any-other-operating-system)
  - [Additional installation options](#additional-installation-options)
- [Upgrading RVM](#upgrading-rvm)
- [Basic RVM usage](#basic-rvm-usage)
  - [Installing ruby](#installing-ruby)
  - [Switching between ruby versions](#switching-between-ruby-versions)
  - [Other RVM commands](#other-rvm-commands)
- [Reporting issues](#reporting-issues)
  - [Check documentation](#check-documentation)
  - [Try again with latest RVM](#try-again-with-latest-rvm)
  - [File an issue](#file-an-issue)
- [Contributing](#contributing)
- [License](#license)

## Installing RVM

### Ubuntu

RVM have dedicated Ubuntu package, so please follow instructions posted here: https://github.com/rvm/ubuntu_rvm
 
If you need a different (newer) version of RVM, after installing base version of RVM check the [Upgrading](#upgrading) section below. 

### Any other operating system

Make sure you have following required packages installed:

* `curl`
* `gpg2`

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
* `truffleruby` - high performance ruby using GraalVM

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

RVM comes bundled with many different tools for managing your ruby environment. More detailed information about every commands listed below can be read after executing `rvm help COMMAND` or browsing documentation on RVM homepage [https://rvm.io](https://rvm.io).

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

Any and all contributions offered in any form, past present or future are understood to be in complete agreement and acceptance with our [Apache License](LICENSE) v2.0.

## License

Copyright (C) Michal Papis (2011-2017), Piotr Kuczynski (2016-2017), Wayne E. Seguin (2009-2011) 

Licensed under the [Apache License](LICENSE), Version 2.0
