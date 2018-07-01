# Wrapper

Show/regenerate wrappers.

NOTE: This command delegates to 'gem wrapper' => <https://github.com/rvm/gem-wrappers>

## Usage

Show paths and generated wrappers:

    rvm wrapper show


Show path to generated wrapper:

    rvm wrapper show executable_name

Where `executable_name` is something like `ruby` or `rake`.


It is also possible to generate a wrapper for external scripts that require ruby:

    rvm wrapper /full/path/to/script

Where `/full/path/to/script` is full path to existing script


Wrappers are generated automatically, but it is possible to rerun the process:

    rvm wrapper regenerate


Documentation:

    rvm wrapper [help]
