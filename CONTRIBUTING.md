# How to hack on RVM

## Fetch and try test suite on your rvm installation

Note that the [`vboxtest`](docs/vm_tests.md) approach is now outdated.
It's better to use the
[`rvm-test`](https://github.com/wayneeseguin/rvm-test/) test suite
which lives in a separate git submodule.  (It's separate in order to
allow reuse when hacking on rvm2).

    $ git submodule init    # Register the rvm-test submodule in .git/config
    $ git submodule update  # Check out the rvm-test submodule

Now read [`rvm-test`'s
README.md](https://github.com/wayneeseguin/rvm-test/blob/master/README.md)
and follow those instructions to make sure you can successfully run
the tests (you will need rvm already installed).

## Set up test installation of rvm

You need a test rvm install to run the test suite against:

    $ git clone https://github.com/wayneeseguin/rvm  # or your own github fork
    $ cd rvm
    $ rvm switch ~/path/to/rvm/test/install          # choose a path here
    $ ./install

This will create a test installation of rvm in
`~/path/to/rvm/test/install`, and as long as `$rvm_path` points to it,
this will be used when running the tests.  This means you can safely
break the test installation without risking breaking your main rvm
installation.

If you want to do manual testing on the CLI against this test installation,
you also need to do:

    $ rvm reload

To get back to using orginal rvm installation run:

    $ rvm switch ~/.rvm

## Hacking RVM via TDD (Test-Driven Development)

First write a test for the behaviour you expect.  For details on how
to write new tests, see [`rvm-test`'s
README.md](https://github.com/wayneeseguin/rvm-test/blob/master/README.md).
Then run the test:

    $ tf --text rvm-test/fast/foo_comment_test.sh

It should fail.  Now repeat the following steps until the test passes:

    1. hack the changes in your rvm src tree
    2. run `./install`
    3. re-run the test (you can also manually test via rvm commands on the CLI)

Now `git commit`, `git push` to your github fork, then issue a pull
request, and if it is accepted then your place in hacker heaven is
secured.

## Getting help

If you get stuck, you should ask on `#rvm-test` or `#rvm` on Freenode.
