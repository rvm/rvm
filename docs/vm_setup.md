Setting up a VM
------------------------

The only real requirement to allow testing of RVM on a VM is that the VM be
reachable by ssh. If you choose to run your VMs on [VirtualBox] and take care
with a few snapshots then you can use some extra rake commands that expedite
testing. Specifically you can reset+start and stop the VMs using:

  rake vbox:start
  rake vbox:stop

As an example, build a [Ubuntu] VM on [VirtualBox] using the following:

- name: ubuntu
- Linux/Ubuntu
- 512 MB memory
- 8 GB dynamically resizing drive

Add the iso to the cd/dvd device under Settings > Storage. Now start the
server and install ubuntu (use default settings unless specified):

- user/password: vboxtest
- select 'OpenSSH server' in packages to install

When the server has rebooted and is ready at the login screen, remove the
install iso, take a snapshot and setup port forwarding. The snapshot is for
convenience. Port forwarding allows you to ssh to yourself on one port (2220)
and have that be received by the VM on another port (22).

    (Devices > CD/DVD Devices > Remove disk from virtual drive)
    VBoxManage snapshot ubuntu take RAW
    VBoxManage controlvm ubuntu poweroff
    # wait to fully power off
    VBoxManage modifyvm ubuntu --natpf1 'ubuntu-ssh,tcp,,2220,,22'
    VBoxManage -q snapshot ubuntu restore RAW
    VBoxManage startvm ubuntu

Transfer your ssh key to the vm. Help to generate ssh keys can be found on
[GitHub](http://help.github.com/key-setup-redirect):

    scp -P 2220 -o UserKnownHostsFile=/dev/null ~/.ssh/id_rsa.pub vboxtest@localhost:id_rsa.pub

Setup SSH for your user:

    vm: mkdir .ssh
    vm: mv id_rsa.pub .ssh/authorized_keys
    vm: chmod 0700 .ssh
    vm: chmod 0600 .ssh/authorized_keys

Remove the login banner (cleans up test output) and exit.

    vm: sudo rm /etc/motd
    vm: exit

Now take some standard snapshots. By taking them at the login screen you can
reset to a running VM, which avoids startup overhead.

    VBoxManage snapshot ubuntu take BASE
    VBoxManage snapshot ubuntu take CURRENT
    VBoxManage controlvm ubuntu poweroff

To cleanup the port forwarding (run later, if ever):

    VBoxManage modifyvm ubuntu --natpf1 delete 'ubuntu-ssh'

Now add configs for this VM to config/ssh:

    Host ubuntu
    HostName localhost
    Port 2220
    User vboxtest

Note that the Host, Port, and User should match up to the values you used
during the VM setup. To add additional VMs, for instance to test on different
operating systems, choose another name/port and repeat.

[VirtualBox]: http://www.virtualbox.org/
[Ubuntu]: http://www.ubuntu.com/
