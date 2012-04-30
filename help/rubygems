∴ rvm rubygems [x.y.z|latest-x.y|latest|current|master|head]

Installs a specific rubygems version in the current ruby. If
'current' is specified, the most current rubygems known to RVM
will be installed.

Currently only compatible with MRI 1.8.*, 1.9.* and Ruby
Enterprise Edition. If your system is not supported, running the
command will generate an error message.

MRI 1.9.* ships with a version of RubyGems. To revert to that version
after installing a custom version via 'rvm rubygems' run:

'rvm rubygems remove'

The version can be also specified as latest-1.8
which will use latest available like 1.8.18

Also you could use "head" or "master" to use development version.
RVM and Rubygems discourage the use of development version.

Finally you can override default version with:

    echo "rubygems_version=latest-1.8" >> $rvm_path/user/db
    echo "ree_rubygems_version=latest-1.6" >> $rvm_path/user/db
    echo "ruby_1.9.2_p136_rubygems_version=1.3.7" >> $rvm_path/user/db
