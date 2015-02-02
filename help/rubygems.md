    $ rvm rubygems [x.y.z|latest-x.y|latest|current|master|head]

Installs a specific rubygems version in the current ruby. If
'current' is specified, the most current rubygems known to RVM
will be installed.

This does not work on Opal, on MRuby and on JRuby older than 1.7.1.

MRI 1.9+ ships with a version of RubyGems. To revert to that version
after installing a custom version via 'rvm rubygems' run:

'rvm rubygems remove'

The version can be also specified as latest-1.8
which will use latest available like 1.8.18

Also you could use "head" or "master" to use development version.
RVM and Rubygems discourage the use of development version.

Finally you can override default version for all installations:

    echo "rubygems_version=latest-1.8" >> $rvm_path/user/db
    echo "ree_rubygems_version=latest-1.6" >> $rvm_path/user/db
    echo "ruby_1.9.2_p136_rubygems_version=1.3.7" >> $rvm_path/user/db

or during single ruby installation:

    rvm install ruby --rubygems latest-2.0

or skip rubygems installation:

    rvm install rbx --rubygems ignore
