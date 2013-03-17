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

## Compilation threads

RVM by default will try to detect amount of CPU cores and use `-j <max>`,
specify your own `-j n` flag to RVM to override the default:

    rvm install 2.0.0 -j 50 # OR:
    rvm install 1.8.6 -j 1

## Binary rubies

By default RVM will try to download binary ruby package instead of compiling.
If such package is not available normal compilation will be performed.
Using binary builds can significantly decrease ruby installation time.

There are two options controlling binary rubies installation:

- `--binary` - force binary installation, do not try to compile ruby.
- `--disable-binary` - do not try binary ruby, always compile.

More details about managing binary rubies can be found in `rvm help mount`.

### Movable rubies

It is possible to build a ruby that can be moved to other locations, renamed
or even moved to other machine - as long as the system matches.

This option works only for ruby **1.9.3**, ruby **1.9.2** supports this only
on systems without `/usr/lib64`.

More details about managing binary builds can be found in `rvm help mount`.

## Verification

`--verify-downloads {0,1,2}` specifies verification level:

- `0` - only verified allowed,
- `1` - allow missing checksum,
- `2` - allow failed checksum.

Please see the documentation for further information:

- https://rvm.io/rubies/installing/
- https://rvm.io/rubies/named/
