## README

At RVM we use GPG to sign files/releases - for security.
This docs is a placeholder where we will be adding information on how to
setup and use GPG, both for developers and users.

#### Note: gpg vs. gpg2

Both should be fine, sometimes `gpg` has problems downloading keys from 
server, it might be better to work with `gpg2` if it's available for 
your's system.

## For users

Make sure to only trust the keys of people you trust - if you trust to 
run our code - trust our keys.

1. import keys:

        gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 # mpapis@gmail.com


2. refresh keys:

    This step helps to ensure none of the developer keys got revoked,
    it's best to do it periodically - or just add it to cron.

        gpg2 --refresh-keys


3. trust developers:

        echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg2 --import-ownertrust # mpapis@gmail.com


4. verified installation:

        \curl -sSL https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer     -o rvm-installer &&
        \curl -sSL https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc -o rvm-installer.asc &&
        \gpg2 --verify rvm-installer.asc &&
        \bash rvm-installer


5. RVM automates GPG for updates to ensure security, no manual steps are needed after installation.


## For developers

1. [Creating GPG Keys](https://alexcabal.com/creating-the-perfect-gpg-keypair/)

2. [Extending key expiration date](https://www.g-loaded.eu/2010/11/01/change-expiration-date-gpg-key/)

3. signing installer:

        gpg --armor --sign-detach binscripts/rvm-installer


4. signing release (follow on screen instructions):

        bash sign-releases.sh


5. places to update when adding new developer key:

    * <https://github.com/rvm/rvm-site/tree/master/content> - add public key (`gpg --armor --export developer_name > developer_name.asc`)
    * <https://github.com/rvm/rvm-site/blob/master/content/index.haml> - section: `Install RVM`
    * <https://github.com/rvm/rvm-site/blob/master/content/rvm/install.md> - beginning
    * <https://github.com/rvm/rvm/blob/master/binscripts/rvm-installer> - function: `verify_package_pgp`
    * <https://github.com/rvm/rvm/blob/master/scripts/functions/cli> - function: `verify_package_pgp`
