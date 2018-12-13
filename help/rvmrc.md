    $ rvm rvmrc {trust,untrust,trusted,load,reset} [optional-path]
    $ rvm rvmrc create {ruby-version} [--rvmrc|--ruby-version|--versions-conf]
    $ rvm rvmrc warning [ignore|reset|list] [<optional-path>|all.rvmrcs|allGemfiles]
    $ rvm rvmrc to ruby-version

Tools for dealing with and loading the rvmrc trust for a given directory.
All actions take an optional path to a directory to check.

Examples:

To check the status of ~/My/project, you would run:

    $ rvm rvmrc trusted ~/My/project

Or, more conventionally,

    $ cd ~/My/project && rvm rvmrc trusted

To manually set it as trusted:

    $ rvm rvmrc trust ~/My/project

Or, to reset the trust and force a prompt:

    $ rvm rvmrc reset ~/My/project
    $ rvm rvmrc reset all

Finally, to load the rvmrc in a directory, you would run:

    $ rvm rvmrc load ~/My/project

Or,

    $ cd ~/My/project && rvm rvmrc load

Note that this replaces 'rvm load-rvmrc'. Note that load implicitly trusts the
rvmrc, even if it is set to untrusted.


Creating project rvmrc files can easily be done with the following command:

    $ rvm --rvmrc --create use 1.9.2@funky

Or for scripting,

    $ rvm rvmrc create 1.9.2@funky

Above command will create both the gemset 'funky', and a project rvmrc file in the current directory.

From RVM 1.11.0 new project files are available.  They do not require trusting:

-    $ rvm rvmrc create 1.9.2@funky --ruby-version
-    $ rvm rvmrc create 1.9.2@funky --versions-conf
- https://rvm.io/workflow/projects/#ruby-versions
