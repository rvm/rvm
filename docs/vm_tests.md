VM Tests
=============================================================================

RVM lives in the shell and so is tested in a shell. To make things easier, RVM
has the ability to test on one or more virtual machines. The setup only
requires that VMs be reachable by ssh, however you get a few helper tasks if
you run your VMs using [VirtualBox].

See below for an overview of the VM test architecture.

Running Locally
------------------------

To run locally (generally not recommended due to possible side effects):

    ./vboxtest/test_suite.sh

Or, equivalently:

    rake vbox:local_test

To add another test suite, make a script in the test directory that ends with
`_test.sh` and ensure it is executable. Then follow this pattern:

    #!/bin/sh

    ########################################################################
    TEST_CASE=$(basename "$0")
    ########################################################################
    . ${0%/$TEST_CASE}/../test_helper.sh

    test_echo_echos_a_string_to_stdout () {
    # The assert_equal method will check that the echo command exits
    # with status 0, and that the stdout is 'hello world'.
    #
    # There are similar assertions to just check the exit status
    # or just check stdout.

      assert_equal 0 "$(
      echo 'hello world'
    )" $LINENO <<stdout
    hello world
    stdout

    # Write as many assertions as you please in a given method.
    }

    run_test_case "$0"

You can write as many test methods as you like... just follow the same
conventions as in Test::Unit (ie start the method with `test_`). See the tests
for more examples.

Running on VMs
------------------------

First set up some virtual machines by following the instructions in
doc/vm_setup. Now to run the tests:

    # starts each of the VMs
    rake vbox:start

    # copies the test scripts to each vm and runs the test suite on each
    rake vbox:remote_test

    # stops each of the VMs
    rake vbox:stop

Or you can run the whole shebang with:

    rake vbox:test

If you aren't running your VMs on VirtualBox and as set up in the docs, then the start/stop commands won't work.  You still can use the `vbox:remote_test` task, you just need to manage your VMs manually.

Overview of VM Test Architecture
==============================================================================

For those interested in the details...

The basic plan is to copy scripts to a VM and then execute one of them to run
the test suite.

The vboxtest.sh script does just that - it makes a directory on each VM,
copies scripts to it, then remotely executes the test runner, all via ssh. As
it does so, output is sent back to your terminal.

The trick is to use ssh with a config file. The config file allows you to
specify the options used by ssh in one place and access them by host name.
That way you can provide a simple list of hosts to vboxtest.sh rather than a
varied and complex set of connection information. As a convenience the
`vbox:remote_test` task runs vboxtest.sh with all hosts in config/ssh.

The beauty of this setup is that it can go anywhere ssh can go to... at the
level of vboxtest.sh, it's pure ssh... and it can do so with a standard ssh
config file.

VirtualBox
------------------------

You don't have to use VirtualBox, but if you do then you can work a few more tricks.

Specifically you can name your VirtualBox VMs the same as each host.  So make a VirtualBox VM named 'ubuntu' and add a host named 'ubuntu', a VM named 'debian' and a host named 'debian'.  Then you setup port forwarding so that you can ssh to localhost:2220 and that goes to ubuntu:22 and localhost:2221 to debian:22.

If you've been consistent about your setup you can reuse a lot of the ssh options giving you a tidy, scalable config file like this:

    Host ubuntu
    Port 2220

    Host debian
    Port 2221

    # Defaults used by all hosts
    Host *
    HostName localhost
    User vboxtest

Since your VirtualBox VMs are named the same as the hosts, you can pull them
out and have rake start/stop the VMs for you using the VBoxManage command
(which comes with VirtualBox).

The SSH Config File
------------------------

A couple ssh options can be used to expedite testing:

    # loosen up the ssh checks so you just go without being 100% secure
    # (good for a test environment)
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
    IdentitiesOnly yes

    # setup a master socket so that the full ssh exchange doesn't have
    # to happen every time you connect (which is 3 times per-host).
    ControlMaster auto
    ControlPath /tmp/socket-%r@%h:%p

The master socket drastically reduces overhead. Note that the master socket is
cleaned up automatically when the VM is shut down.

[VirtualBox]: http://www.virtualbox.org/
