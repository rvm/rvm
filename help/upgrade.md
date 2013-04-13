Usage:

  rvm upgrade {source ruby} [destination ruby] [--force]

Description:

  Upgrades the specified (already installed) source ruby to the
  given destination ruby version. Will migrate gemsets, wrappers, aliases
  and environment files.

  The process will prompt you at each stage - if the versions look incorrect,
  please cancel and perform it manually.


Examples:

    $ rvm upgrade 1.9.2-p136 1.9.2-p180

    $ rvm upgrade ree-2011.01 ree-2011-02

append `--force` to answer yes to all questions.

Experimental detection:

    $ rvm upgrade 1.9.2
    Are you sure you wish to upgrade from ruby-1.9.2-p290 to ruby-1.9.2-p318? (Y/n):
