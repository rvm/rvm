## Usage

    rvm install {ruby-string} [--verify-downloads {0,1,2}] [--binary|--disable-binary|--movable]


For a partial list of valid ruby strings please run

    rvm list known

For MRI Rubies you may pass configuration parameters in one of two ways:

    rvm install 1.9.2 --with-iconv-dir=$HOME/.rvm --without-readline

and/or

    rvm install 1.9.2 -C --with-iconv-dir=$HOME/.rvm,--without-readline

To do dirty installation using the same sources use:

    rvm install --force 1.9.2

To do clean installation use:

    rvm reinstall 1.9.2

## Fetching ruby package

You can customize fetching ruby package (source or binary) process with following options:

- `--quiet-curl`         - make `curl` silent when fetching data
- `--force`              - remove old installation with sources and force install

## Architecture

By default RVM will install 64-bit rubies, but you specify alternative
using switches:

- `--32`                   - install 32-bit rubies
- `--64`                   - install 64-bit rubies (default)
- `--universal`            - install both (OSX only)
- `--arch` | `--archflags` - architectures to install

## Binary rubies

By default RVM will try to download binary ruby package instead of compiling.
If such package is not available normal compilation will be performed.
Using binary builds can significantly decrease ruby installation time.

There are two options controlling binary rubies installation:

- `--binary`         - force binary installation, do not try to compile ruby.
- `--disable-binary` - do not try binary ruby, always compile.

More details about managing binary rubies can be found in `rvm help mount`.

## Installing from source

If you installing ruby package by compiling it from source, you can pass
additional configuration options:

- `--reconfigure`      - force `./configure` on install even if `Makefile` already exists
- `--patch`            - with MRI Rubies you may specify additional patches to apply before install - multiple patches should be comma separated `--patch a.patch[%prefix],b.patch` - `prefix` is an optional argument, which will be bypassed to the `-p` argument of the `patch` command and should be separated from patch file name with the `%` symbol.

### Compilation options
- `--clang`                          - use clang for compilation (equivalent to `export CC=clang` + `export CXX=clang++`)
- `--disable-llvm` | `--disable-jit` - disable LLVM
- `--enable-llvm` | `--enable-jit`   - enable LLVM

- `--with-arch`                      - architecture flag for configure (e.g. i686, x86_64)
- `-C` | `--configure` | `--`        - custom configure options - multiple options can be specified, separated with comma
- `--with-*` | `--without-*`         - configure flags
- `--enable-*` | `--disable-*`       - configure flags
- `-E` | `--env`                     - environment flags for configure
- `-M`                               - custom make options


### Package-specific options

rbx & jruby:
- `--1.8` | `--1.9` | `--2.0` | `--2.1` - use branch compatible with given MRI ruby version
- `--18` | `--19` | `--20` | `--21`     - same

ree:
- `--ree-options`   - options passed directly to ree's `./installer` on the command line

### Compilation threads

RVM by default will try to detect amount of CPU cores and use `-j <max>`,
specify your own `-j n` flag to RVM to override the default:

    rvm install 2.0.0 -j 50 # OR:
    rvm install 1.8.6 -j 1

### Movable rubies

It is possible to build a ruby that can be moved to other locations, renamed
or even moved to other machine - as long as the system matches.

This option works only for ruby **1.9.3**, ruby **1.9.2** supports this only
on systems without `/usr/lib64`.

More details about managing binary builds can be found in `rvm help mount`.

## Documentation

- `--docs`              - generate ri after installation (default)
- `--rdoc` | `--yard`   - type of docs to generate (default: rdoc)
- `--no-docs`           - disable ri after installation

## Additional settings

- `--skip-gemsets`                     - skip the installation of default gemsets
- `--bin`                              - path for binaries to be placed (default: `~/.rvm/bin/.`)
- `-l` | `--level`                     - MRI ruby patch level
- `--url` | `--repository` | `--repo`  - git URL of repository to install from
- `--branch`                           - branch to install from
- `--tag`                              - tag to install from
- `--sha`                              - SHA of commit to install from
- `--trace`                            - add time, path, etc details to log
- `--proxy`                            - proxy options to pass to curl for downloading packages

## Verification

`--verify-downloads {0,1,2}` specifies verification level:

- `0` - only verified allowed,
- `1` - allow missing checksum,
- `2` - allow failed checksum.

Please see the documentation for further information:

- https://rvm.io/rubies/installing/
- https://rvm.io/rubies/named/
