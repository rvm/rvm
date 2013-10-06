Alias

  RVM allows you to alias your rubies for your convenience and pleasure.

Usage
  rvm [options] alias source destination

  Source and Destination must be an RVM
  ruby string representing an RVM installed ruby.

  A gemset may be optionally included.

Creating Aliases

  First select an RVM ruby.

    $ rvm alias create php ree-1.8.7-p2010.01

Using Aliases

  Now that you have created an alias, you can use the alias in place of the longer rvm selector string.

    $ rvm use php
    $ ruby -v
    ruby 1.8.7 (2009-12-24 patchlevel 248) [i686-darwin10.3.0], MBARI 0x6770, Ruby Enterprise Edition 2010.01

If you use any aliases that are rather funny, please hop in #rvm and let us know :)

Deleting Aliases

  If you wish to delete an alias

    $ rvm alias delete dotnet
    Listing Aliases

You can also list all current aliases

    $ rvm alias list
    php => ree-1.8.7-p2010.01
    lisp => maglev-head
    python => rbx-head

Managing Generic Ruby Versions

  You can use aliases to set a specific ruby patchlevel for a generic ruby
  version. This is useful if you have upgraded RVM and can no longer switch
  to the requested ruby. For example, if your project specifies
  `ruby-1.9.3@my-project` you can do this:

    $ cd my-project/
    ruby-1.9.3-p448 is not installed.
    To install do: 'rvm install ruby-1.9.3-p448'
    $ rvm alias create ruby-1.9.3 ruby-1.9.3-p429
    Creating alias ruby-1.9.3 for ruby-1.9.3-p429.
    Recording alias ruby-1.9.3 for ruby-1.9.3-p429.
    $ cd .
    $ ruby -v
    ruby 1.9.3p429 (2013-05-15 revision 40747) [x86_64-linux]

Documentation:

  https://rvm.io/rubies/alias/

