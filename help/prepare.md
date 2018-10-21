Usage:

    rvm prepare ruby-version [--path]

## Preparing your own build of ruby

When using a custom system it is also possible to build your own binary ruby:

    rvm prepare 1.9.3

It will generate `ruby-1.9.3-p194.tar.bz2` in the current directory,
it can be either used directly as file, or hosted on a https server.

You can also tell RVM to upload to scp server:

    rvm prepare 1.9.3 -r rvm@ssh.rvm.io:~/shared/public/binaries

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

When corresponding path is not defined for url then it is autodetected.

Example `$rvm_path/user/db`:

    rvm_remote_server_url3=http://server/binaries
    rvm_remote_server_path3=my_distribution
    rvm_remote_server_verify_downloads3=1
