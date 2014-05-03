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


## Unmounting locally compiled rubies

Remove the ruby as you would any other:

    rvm remove ext-ruby-1.9.3-p194


## Downloading compiled ruby (since RVM 1.16)

RVM also supports downloading compiled rubies.

You can specify the full url to the binaries:

    rvm mount -r https://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-1.9.3-p194.tar.bz2

It is also possible to download from different url with a name to use:

    rvm mount -r https://some.server/my_ruby-1.9.3-p194.tar.bz2 ruby-1.9.3-p194

Note that the packaged ruby must be using exactly the name that was given as second parameter.

And finally it is possible to just give a name and RVM will build the path for your system:

    rvm mount -r 1.9.3

Assuming the binary is in proper remote path registered with rvm it will be automatically used during installation:

    rvm install 1.9.3

will use https://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-1.9.3-p194.tar.bz2 assuming it is 64bit Ubuntu 12.04.


## List of available builds

RVM automatically detects current platform and displays rubies available for it:

    rvm list remote


## Preparing your own build of ruby

Read more in:

    rvm help prepare
