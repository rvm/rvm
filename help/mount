Usage:

    rvm automount
    rvm mount /path/to/ruby [-n {name}]
    rvm mount [-r] {https://url/to/ruby.tar.bz2} [name]


## Mounting local compiled rubies

RVM supports adding rubies compiled by user.

If compiled ruby is already on `PATH` then use:

    rvm automount

If ruby is not on `PATH` and was compiled in `/opt/ruby-1.9.3-p194`,
then both following commands will add it to RVM:

    rvm mount /opt/ruby-1.9.3-p194
    rvm mount /opt/ruby-1.9.3-p194/bin/ruby

RVM will ask user for the name for it, for automation you can use `-n` flag:

    rvm mount /opt/ruby-1.9.3-p194 -n ruby-1.9.3-p194

Which will create `ext-ruby-1.9.3-p194`, the `ext-` prefix is there to
distinguish externally compiled rubies.


## Downloading compiled ruby (since RVM 1.16)

RVM also supports downloading compiled rubies.

You can specify full url to the binaries:

    rvm mount -r https://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-1.9.3-p194.tar.bz2

It is also possible to download from different url with a name to use:

    rvm mount -r https://some.server/my_ruby-1.9.3-p194.tar.bz2 ruby-1.9.3-p194

Note that the packaged ruby must be using exactly the name that was given as second parameter.

And finally it is possible to just give a name and RVM will build the path for your system:

    rvm mount -r 1.9.3


## List of available builds

RVM automatically detects current platform and displays rubies available for it:

    rvm list remote


## Preparing your own build of ruby

When using custom system it is also possible to build your own ruby:

    rvm prepare 1.9.3 --install

It will generate `ruby-1.9.3-p194.tar.bz2` in current directory,
it can be either used directly as file, or hosted on https server.

You can also tell RVM to upload to scp server:

    rvm prepare 1.9.3 -r rvm@rvm.io:~/shared/public/binaries

It will show commands to run to update server, and changes for rvm files.

Finally it is possible to generate the package with paths reflecting server,
especially useful for generating multiple packages for many systems:

    rvm prepare 1.9.3 --path


## Hosting binaries build server

You can also host your rubies on your server, this is useful when using patches,
custom compilation options or hardcoded installation path.

RVM requires just https server for your own hosting, the pattern for building url is:

    "${rvm_remote_server_url}/${rvm_system_server_path}/${rvm_ruby_string}.tar.bz2"

Where:

- `rvm_remote_server_url`  - can be defined in `$rvm_path/user/db`
- `rvm_system_server_path` - can be defined in `$rvm_path/user/db`, autodetected if not defined
- `rvm_ruby_string` - is the name specified by user

For multiple servers/paths suffix the definition with numbers, for example:

    rvm_remote_server_url=https://own.company.com/binaries
    rvm_system_server_path=my/system
    rvm_remote_server_url1=https://rvm.io/binaries

When coresponding path is not defined for url then it is autodetected.
