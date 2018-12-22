# GPG

1. [Creating GPG Keys](https://alexcabal.com/creating-the-perfect-gpg-keypair/)

2. Add public key to rvm-site repo

    `gpg --armor --export developer_name > developer_name.asc`

2. [Extending key expiration date](https://www.g-loaded.eu/2010/11/01/change-expiration-date-gpg-key/)

3. Signing installer

    `gpg --armor --detach-sign --yes binscripts/rvm-installer`

4. Signing release (follow on screen instructions)

    `bash sign-releases.sh`
