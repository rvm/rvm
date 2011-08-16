Testing
=============================================================================

RVM lives in the shell and so is tested in a shell. The test directory
contains shell-based unit tests.

To run locally:

    ./test/test_suite.sh

Or:

    rake vbox:local_test

To add another test suite, make a script in the test directory that ends with
`_test.sh` and ensure it is executable. Then follow the pattern in
`example_test.sh`:

    #!/bin/sh

    ########################################################################
    TEST_CASE=$(basename $0)
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
conventions as in Test::Unit (ie start the method with `test_`).

Running on VMs
------------------------

First set up some virtual machines by following the instructions in
doc/vm_setup. Then copy config/ssh.example to config/ssh and replace the
USERNAME comment with your user for the virtual machines. You can add/remove
hosts as you please; each host should correspond to the name of a VM in
[VirtualBox](http://www.virtualbox.org/). The only requirement is that the VM
can be reached via ssh.

Now to run the tests:

    # starts each of the VMs
    rake vbox:start
    
    # copies the test scripts to each vm and runs the test suite on each
    rake vbox:remote_test
    
    # stops each of the VMs
    rake vbox:stop

Or you can run the whole shebang with:

    rake vbox:test

Setting up a Ubuntu VM
------------------------

As an example, build a Ubuntu VM using the following:

- name: ubuntu
- Linux/Ubuntu
- 512 MB memory
- 8 GB dynamically resizing drive

Add the iso to the cd/dvd device under Settings > Storage. Now start the
server and install ubuntu (use default settings unless specified):

- user/password: vboxtest
- select 'OpenSSH server' in packages to install

When the server has rebooted and is ready at the login screen, remove the
install iso, take a snapshot and setup port forwarding.

    (Devices > CD/DVD Devices > Remove disk from virtual drive)
    VBoxManage snapshot ubuntu take RAW
    VBoxManage controlvm ubuntu poweroff
    # wait to fully power off
    VBoxManage modifyvm ubuntu --natpf1 'ubuntu-ssh,tcp,,2220,,22'
    VBoxManage -q snapshot ubuntu restore RAW
    VBoxManage startvm ubuntu

Transfer your ssh key to the vm. Help to generate ssh keys can be found on
[GitHub](http://help.github.com/key-setup-redirect):

    scp -P 2220 -o UserKnownHostsFile=/dev/null ~/.ssh/id_rsa.pub USERNAME@localhost:id_rsa.pub

Setup SSH for your user:

    vm: mkdir .ssh
    vm: mv id_rsa.pub .ssh/authorized_keys
    vm: chmod 0700 .ssh
    vm: chmod 0600 .ssh/authorized_keys

Remove the login banner and exit:

    vm: sudo rm /etc/motd
    vm: exit

Now take some standard snapshots:

    VBoxManage snapshot ubuntu take BASE
    VBoxManage snapshot ubuntu take CURRENT
    VBoxManage controlvm ubuntu poweroff

To cleanup the port forwarding (run later, if ever):

    VBoxManage modifyvm ubuntu --natpf1 delete 'ubuntu-ssh'
