# Change Log

## [Unreleased](https://github.com/rvm/rvm/tree/HEAD)

[Full Changelog](https://github.com/rvm/rvm/compare/1.29.1...HEAD)

#### New features:
* Add support for elementary OS [\#3935](https://github.com/rvm/rvm/issues/3935)
* Add support for Deepin (based on Debian) [\#3999](https://github.com/rvm/rvm/issues/3999) 
* Simplified OS detection mechanism [\#3938](https://github.com/rvm/rvm/pull/3938)

#### Bug fixes:
* Use actual executable test instead of mount|grep noexec for robust noexec detection [\#3933](https://github.com/rvm/rvm/pull/3933)
* "Unknown ruby string (do not know how to handle)" when specifying Ruby version w/a gemset [\#3292](https://github.com/rvm/rvm/issue/3292)
* Fix the required openssl version for ruby 1.8 on OSX [\#3955](https://github.com/rvm/rvm/issue/3955)
* Detect `.` as an alternative to `source` in bash profile warning [\#3960](https://github.com/rvm/rvm/issues/3960)
* Allow users to specify irb history file using IRB.conf[:HISTORY_FILE] [\#3969](https://github.com/rvm/rvm/pull/3969)
* Prefer github issues over IRC support [\#3939](https://github.com/rvm/rvm/issues/3939)
*	Architecture detection using uname instead of dpkg [\#3948](https://github.com/rvm/rvm/issues/3948)
* Help section of the rvm.io page points to irc.freenode.net instead of github [\#3939](https://github.com/rvm/rvm/issues/3939)
* Make sure stderr output is printed on console and not captured into log files [\#3990](https://github.com/rvm/rvm/issues/3990)
* Clean up errors output, show only log file name [\#3990](https://github.com/rvm/rvm/issues/3990)
* RVM install fail on macOS Yosemite due expired curl's SSL certificate [\#3886](https://github.com/rvm/rvm/issues/3886)
* Fix failing openssl.patch for Ruby 2.2.4 and 2.2.5 [\#3988](https://github.com/rvm/rvm/issues/3988)
* Do not unset rvm_pretty_print_flag [\#3946](https://github.com/rvm/rvm/issues/3946)
* Patch Ruby 2.3.4 with missing rb_thread_fd_close [\#4008](https://github.com/rvm/rvm/issues/4008)
* Unknown subcommand `rvm gemset clear` [\#4004](https://github.com/rvm/rvm/issues/4004)
* Skip rubygems install for ruby-head [\#4022](https://github.com/rvm/rvm/pull/4022)

#### Upgraded Ruby interpreters:
* Add support for Rubinius 3.72 [\#3934](https://github.com/rvm/rvm/pull/3934), 3.73 [\#3979](https://github.com/rvm/rvm/pull/3979), 3.74 [\#3994](https://github.com/rvm/rvm/pull/3994), 3.75 [\#4002](https://github.com/rvm/rvm/pull/4002), 3.76 and 3.77 [\#4016](https://github.com/rvm/rvm/pull/4016)
* Add support for JRuby 9.1.8.0 [\#3952](https://github.com/rvm/rvm/pull/3952)
* Add support for Ruby 2.4.1 [\#3963](https://github.com/rvm/rvm/pull/3963)
* Upgrade RubyGems to 2.6.11 [\#3962](https://github.com/rvm/rvm/pull/3962)
* Add support for Ruby 2.2.7 [\#3970](https://github.com/rvm/rvm/pull/3970)
* Add support for Ruby 2.3.4 [\#3973](https://github.com/rvm/rvm/pull/3973)
* Upgrade RubyGems to 2.6.12 [\#4018](https://github.com/rvm/rvm/pull/4018)
* Add support for JRuby 1.7.27 [\#4026](https://github.com/rvm/rvm/pull/4026)

#### Binaries:
* Ubuntu x64 binary for Ruby 2.4.1 [\#3965](https://github.com/rvm/rvm/issues/3965)
* Ubuntu x64 binary for Ruby 2.2.7 [\#3971](https://github.com/rvm/rvm/issues/3971)
* Ubuntu x64 binary for Ruby 2.3.4 [\#3985](https://github.com/rvm/rvm/issues/3985)
* Ubuntu 16.10 x64 binaries for Ruby 1.9.3-p551, 2.0.0-p648, 2.1.5, 2.1.6, 2.1.8, 2.1.9, 2.2.4, 2.2.5, 2.2.6, 2.3.0, 2.3.1, 2.3.2 and 2.3.3 [\#3823](https://github.com/rvm/rvm/issues/3823)

#### Documentation:
* Integrating RVM with Bash on Ubuntu on Windows 10 [\#304](https://github.com/rvm/rvm-site/pull/304)
* Troubleshooting SSL certificate problem: unable to get local issuer certificate [\#3984](https://github.com/rvm/rvm/issue/3984)
* Automatically generated Integration section on Index page [\#305](https://github.com/rvm/rvm-site/pull/305)
* Add info about Ubuntu installation package [\#306](https://github.com/rvm/rvm-site/pull/306)
* Remove subversion as a prerequisite for installing rubies [\#277](https://github.com/rvm/rvm-site/issue/277)
* Added missing information that user should have sudo rights to install rubies [\#307](https://github.com/rvm/rvm-site/pull/307)
* Better explanation for `apt-get update` failing with 404 Not Found errors [\#3411](https://github.com/rvm/rvm/issue/3411)
* Ruby 2.1 is no more maintained [\#3997](https://github.com/rvm/rvm/pull/3997)

## [1.29.1](https://github.com/rvm/rvm/tag/1.29.1)

19 February 2017 - [Full Changelog](https://github.com/rvm/rvm/compare/1.29.0...1.29.1)

#### Bug fixes:
* Fix using ruby from current dir when no params [\#3880](https://github.com/rvm/rvm/issues/3880)
* Fix Ruby/Openssl installation on OSX [\#3923](https://github.com/rvm/rvm/issues/3923)
* Fix rvm info to be yaml compatible [\#3924](https://github.com/rvm/rvm/issues/3924)
* Add explicit architecture check for debian/ubuntu [\#3927](https://github.com/rvm/rvm/issues/3927)
* Fix detecting openssl path for ruby24 [\#3928](https://github.com/rvm/rvm/issues/3928)


## [1.29.0](https://github.com/rvm/rvm/tag/1.29.0)

12 February 2017 - [Full Changelog](https://github.com/rvm/rvm/compare/1.28.0...1.29.0)

#### Security fixes:
* add trusting working directory hooks
* add trusting project files with environment variables
* prevent executing code when loading variables from project files
* remove posibility to install gems from .versions.conf
* do not 'bundle install' if no rvm_autoinstall_bundler_flag=1
* install bundler only from remote server
* handle spaces in working directory hook names
* avoid double escaping of envirtonment variables
* avoid extra quotation if it was used in the project file

#### New features:
* Added railsexpress patches for Ruby 2.3.3 [\#3852](https://github.com/rvm/rvm/pull/3852)
* Add support for KDE neon [\#3828](https://github.com/rvm/rvm/pull/3828)
* Allow to remove undesired libraries breaking the ruby build [\#3851](https://github.com/rvm/rvm/issues/3851)
* Mention in PATH warnings about ability to silence them [\#3336](https://github.com/rvm/rvm/issues/3336)
* Expose `autolibs` setting in `rvm info` output [\#3892](https://github.com/rvm/rvm/pull/3892)
* Detect `noexec` mount mode for partition hosting RVM home [\#3832](https://github.com/rvm/rvm/pull/3832)

#### Bug fixes:
* Changed `eval` to `source` for fish 2.5.0 compatibility [fish-shell\#3809](https://github.com/fish-shell/fish-shell/issues/3809)
* $PATH become empty after __rvm_unload executed [\#3847](https://github.com/rvm/rvm/pull/3847)
* RVM incorrectly tries to install llvm 3.5 when trying to install Rubinius 3 [\#3848](https://github.com/rvm/rvm/pull/3848)
* Missing libyaml-devel on PCLinuxOS 64-bit [\#3703](https://github.com/rvm/rvm/issues/3703)
* Failing openssl.patch for Ruby 1.9.3 [\#3831](https://github.com/rvm/rvm/issues/3831)
* RVM hardcodes number of compile threads [\#3856](https://github.com/rvm/rvm/pull/3856)
* Cannot build rbx-2.5.2 on ArchLinux [\#3497](https://github.com/rvm/rvm/issues/3497)
* Remove incompatible version of openssl098 [\#3844](https://github.com/rvm/rvm/issues/3844)
* Failed to fetch the gpg key from keys.gnupg.net [\#3544](https://github.com/rvm/rvm/issues/3544)
* Filtering Travis binaries for OSX for non Travis env (they are statically linked and not movable) [\#3690](https://github.com/rvm/rvm/issues/3690)
* Remove kernel-libc-devel dependency on Solus [\#3881](https://github.com/rvm/rvm/pull/3881)
* Speed up loading rubies - gem version compatibility check
* Missing cygwin32-readline package on Windows [\#3812](https://github.com/rvm/rvm/pull/3812)
* Installation of rbx-3.69 on macOS fails because llvm35 formula can't be found [\#3884](https://github.com/rvm/rvm/issues/3884)
* Ruby 2.3.x and older are not compatible with OpenSSL 1.1.x on Debian [\#3862](https://github.com/rvm/rvm/issues/3862)
* OpenSSL vs libressl conflict installing ruby-2.4.0 on openSUSE Tumbleweed [\#3906](https://github.com/rvm/rvm/issues/3906)
* Missing `libgmp3-dev` for Ruby 2.2 on Debian 6 [\#3675](https://github.com/rvm/rvm/issues/3675)
* JRuby on Arch is missing Java requirements [\#3539](https://github.com/rvm/rvm/issues/3539)
* `rvm install 2.4` installs 2.4.0-rc1 instead of 2.4.0 [\#3866](https://github.com/rvm/rvm/issues/3866)
* Use `libreadline-dev` instead of `libreadline6-dev` on Debian (≥stretch) [\#3824](https://github.com/rvm/rvm/issues/3824)
* Warning: openssl is a keg-only and another version is linked to opt [\#3724](https://github.com/rvm/rvm/issues/3724)
* Fix trusting paths with duplicated //
* Fix rvm do in relative paths

#### Upgraded Ruby interpreters:
* Add support for Ruby 2.4.0 [\#3849](https://github.com/rvm/rvm/pull/3849)
* Add support for JRuby 9.1.7.0 [\#3878](https://github.com/rvm/rvm/pull/3878)
* Add support for Rubinius 3.70 [\#3889](https://github.com/rvm/rvm/pull/3889) and 3.71
* Upgrade RubyGems to 2.6.10

#### Binaries:
* Ubuntu x64 binary for Ruby 2.4.0 [\#3867](https://github.com/rvm/rvm/issues/3867)

## [1.28.0](https://github.com/rvm/rvm/tag/1.28.0)

19 December 2016 - [Full Changelog](https://github.com/rvm/rvm/compare/1.27.0...1.28.0)

#### New features:
* Feedback when switching gemset with/without use [\#3780](https://github.com/rvm/rvm/issues/3780)
* Require OpenJDK 1.8.0 (with fallback to 1.7.0) for JRuby on CentOS/Fedora [\#3741](https://github.com/rvm/rvm/pull/3741) and Ubuntu [\#3719](https://github.com/rvm/rvm/pull/3719)
* Updated README including information about dedicated Ubuntu package
* Add support for Solus linux [\#3728](https://github.com/rvm/rvm/pull/3728)

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
