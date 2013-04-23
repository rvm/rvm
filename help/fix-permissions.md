# Fix permissions

## Synopsis

    rvm fix-permissions
    rvm fix-permissions user
    rvm fix-permissions system
    rvm fix-permissions <user>
    rvm fix-permissions <user>:
    rvm fix-permissions <user>:<group>
    rvm fix-permissions :<group>

## Description

In some cases like using sudo or chef permissions of rvm could be broken.
When fixing permissions for group also makes everything group writable.

## Arguments
`rvm fix-permissions`:

* ``               => Fix permissions for `user` or `system` - pick automatically,
* `user`           => Fix permissions for current user,
* `system`         => Fix permissions for system installation of RVM,
* `<user>:<group>` => Fix permissions for given user and/or group
