    $ rvm tools {identifier,path-identifier,strings,mirror,rvm-env}

Provides generic tools related to rvm environments for gaining information
about your current environment.  Primarily used for scripting rvm.

Examples:

To get the expanded Ruby string for the current environment, you would run:

    $ rvm tools identifier

To get the identifier for a folder (taking into account .rvmrc files and the like),
run this instead:

    $ rvm tools path-identifier ~/path/to/directory

Lastly, you can expand example Ruby strings.  E.g., to get the current ree version,
run:

    $ rvm tools strings ree

In case of network/firewall problems, it is easy to define alternate download URLs:

    $ rvm tools mirror


It is possible to use a "shebang" (#!/usr/...) line to select the interpreter
(eg, Ruby 1.9.3) which processes a script file.  However, this will work only
on recent Linux kernels (2.6.27.9 and above).

First, you need to define the shebang wrapper:

    $ rvm tools rvm-env ruby bash zsh

This will define:

    /usr/bin/{ruby,bash,zsh}-rvm-env

Your scripts can then request the proper Ruby, using shebang:

    #!/usr/bin/ruby-rvm-env 1.9.3

The script will be run using Ruby 1.9.3 from rvm.

Alternatively, here is a hack to make a script switch itself:

    if !ENV['ruby_switch_flag']
      ENV['ruby_switch_flag'] = '42'
      system('rvm', '1.9.3', 'do', __FILE__, *ARGV)
      exit 0
    end

