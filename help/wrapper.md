# Wrapper

Show path to wrapper / to all wrappers and
generate links to wrappers to `$rvm_path/bin` for easier use.

Wrappers itself are generated always using <https://github.com/rvm/gem-wrappers>.

## Usage

    rvm wrapper ruby_string show [binary]
    rvm wrapper ruby_string [wrapper_prefix|--no-prefix] [binary[ binary[ ...]]]

where `ruby_string` is the ruby version and gemset combination to provide wrapper links for
(it can also refer to a valid project path or alias), wrapper_prefix is what to prepend to the name
of the generated wrapper, and binary and binaries are the names of the binaries for which you wish
to provide a wrapper (e.g. gem).

## Default binaries

When no binaries are provided, rvm will (by default) generate wrapper links for

    ruby, gem, rake, irb, rdoc, ri, testrb

## Example

If you wish to provide an environment-specific wrapper links for rspec with a rails3 gemset,
you could do:

    $ rvm --create ree@rails3
    $ rvm wrapper ree@rails3 r3 spec

Which would add r3_spec with the specified environment to the bin
directory where you installed rvm.

Alternatively, if you do:

    $ rvm wrapper ruby-1.9.2-head --no-prefix

It will create links named ruby, gem, rake, irb, rdoc, ri and tesrb
in the rvm bin directory.

Finally, to show another real and common use, you can use wrapper
to generate ruby executables and gems for passenger to use. Namely:

    $ rvm use ree@rails3 --passenger

is equivelant to:

    $ rvm use ree@rails3
    $ rvm wrapper ree@rails3 passenger

Which creates passenger_* binaries in the rvm bin directory using
ree and the rails3 gemset.
