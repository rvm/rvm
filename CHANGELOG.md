# Change Log

## [1.28.0](https://github.com/rvm/rvm/tag/1.28.0)

19 December 2016 - [Full Changelog](https://github.com/rvm/rvm/compare/1.27.0...1.28.0)

#### New features:
* Feedback when switching gemset with/without use [\#3780](https://github.com/rvm/rvm/issues/3780)
* Require OpenJDK 1.8.0 (with fallback to 1.7.0) for JRuby on CentOS/Fedora [\#3741](https://github.com/rvm/rvm/pull/3741) and Ubuntu [\#3719](https://github.com/rvm/rvm/pull/3719)
* Updated README including information about dedicated Ubuntu package
* Add support for Solus linux [\#3728](https://github.com/rvm/rvm/pull/3728) ([mspaulding06](https://github.com/mspaulding06))

#### Bug fixes:
* Can't download rvm; curl returned status '23' [\#3785](https://github.com/rvm/rvm/issues/3785)
* Installation fails when cygwin was installed with `--no-admin` flag [\#3762](https://github.com/rvm/rvm/issues/3762)
* Installation fails with `SSLv3_method undeclared` [\#3752](https://github.com/rvm/rvm/issues/3752)
* Updated source urls for Ruby Enterprise Edition [\#3740](https://github.com/rvm/rvm/issues/3740)
* RVM install rbx fails on 10.11.6 with `llvm` version mismatch [\#3722](https://github.com/rvm/rvm/issues/3722)
* Can't install jruby on Ubuntu 16.04: no `openjdk-7-jre-headless` package [\#3719](https://github.com/rvm/rvm/issues/3719)
* Fail to install ruby 2.3.1 on Windows 10 with Cygwin (missing `libcrypt-devel` and `libcrypt0`) [\#3706](https://github.com/rvm/rvm/issues/3706)
* Incorrect requirement `cygwin32-readline` for Cygwin x86_64 [\#2736](https://github.com/rvm/rvm/issues/2736)
* Fish shell error after stable update [\#3655](https://github.com/rvm/rvm/issues/3655)
* Enforce usage of gpg coming from Cygwin on Windows [\#3623](https://github.com/rvm/rvm/issues/3623)
* Change Rubinius dependency llvm to version 3.5 for OpenSuse, macOS and Ubuntu [\#3287](https://github.com/rvm/rvm/issues/3287)
* Print info message when auto switching ruby by entering the folder [\#3602](https://github.com/rvm/rvm/issues/3602)
* Change Rubinius Ubuntu dependency clang to version 3.5 [\#3541](https://github.com/rvm/rvm/issues/3541)
* Patch Ruby to explicitly refer to kernel32.dll on Cygwin [\#3519](https://github.com/rvm/rvm/issues/3519)
* Add libgmp-dev as an Ubuntu requirement [\#3509](https://github.com/rvm/rvm/issues/3509)
* Errors when installing rubies caused by old ruby gems 2.4.x shipped with RVM [\#3742](https://github.com/rvm/rvm/issues/3742)
* Cannot load such file -- zlib [\#3389](https://github.com/rvm/rvm/issues/3389)
* Improved warning message for when PATH= is set without $PATH [\#3776](https://github.com/rvm/rvm/pull/3776)
* Fix error message about ignoring all Gemfiles [\#3771](https://github.com/rvm/rvm/pull/3771)
* Added rails express patches for 2.2.5 and 2.3.1 [\#3676](https://github.com/rvm/rvm/pull/3676)
* Change OpenBSD mirror protocol from ftp to http [\#3673](https://github.com/rvm/rvm/pull/3673)
* Enable building of Ruby 1.9.3 and 2.0.0 on 64bit little-endian PowerPC [\#3666](https://github.com/rvm/rvm/pull/3666)
* Avoid infinite loop on a new tmux session [\#3653](https://github.com/rvm/rvm/pull/3653)

#### Upgraded Ruby interpreters:
* Add support for JRuby 9.1.6.0 [\#3805](https://github.com/rvm/rvm/issues/3805)
* Add support for Ruby 2.2.6, 2.3.2 [\#3808](https://github.com/rvm/rvm/issues/3808), 2.3.3 [\#3819](https://github.com/rvm/rvm/issues/3819), 2.4.0-preview3 and 2.4.0-rc1
* Add support for Rubinius 3.69
* Drop support for GoRuby [\#3786](https://github.com/rvm/rvm/issues/3786)
* Upgrade RubyGems to 2.6.8

#### Binaries:
* Ruby 2.3.0, 2.3.1 [\#3774](https://github.com/rvm/rvm/issues/3774), 2.3.3 [\#3822](https://github.com/rvm/rvm/issues/3822) binaries for Debian 8 x86_64
* Ruby 2.0.0-p648, 2.1.5, 2.1.9, 2.2.5, 2.3.0 [\#3693](https://github.com/rvm/rvm/issues/3693), 2.2.6 and 2.3.2 [\#3809](https://github.com/rvm/rvm/issues/3809), 2.3.3 [\#3820](https://github.com/rvm/rvm/issues/3820) binaries for Ubuntu 16.04 
* Ruby 2.3.1 for Centos 6.6 [\#3712](https://github.com/rvm/rvm/issues/3712)
* Install CentOS binaries on both RedHat and CentOS machines [\#3735](https://github.com/rvm/rvm/issues/3735)


## Previous versions

* [1.7.3 - 1.27](https://github.com/rvm/rvm/compare/1.7.2...1.27.0) (_25 August 2011 - 26 March 2016_)
* [0.0.6](https://github.com/rvm/rvm/blob/939585d8563cad4225fa44e8e78b9173467e8440/CHANGELOG.md#006) - [1.7.2](https://github.com/rvm/rvm/blob/939585d8563cad4225fa44e8e78b9173467e8440/CHANGELOG.md#172-17-august-2011) (_17 August 2011_)
