# OSX OpenSSL Certificates handling.

## Synopsis

    rvm osx-ssl-certs status [<ruby>|<certs-path>|<openssl-binary>|all]
    rvm [--silent] osx-ssl-certs update [<ruby>|<certs-path>|<openssl-binary>|all]
    rvm osx-ssl-certs cron [status|install|uninstall]

## Description

Apple OS X comes with old version of OpenSSL, to keep you secure RVM installs newer version.
RVM also allows specifying custom version of OpenSSL and binary rubies linked to custom locations.
Taken this all into account most likely your Ruby is using outdated certificates.
To solve this problem `rvm osx-ssl-certs` will find all locations for certificates.
You can check status, update certificates manually or schedule an automated update.

## Arguments
`rvm osx-ssl-certs`:

* `status`      => Show certificates status for current Ruby,
  * `<ruby>`    => Status of a specific Ruby certificates,
  * `<certs-path>`     => Status for a specific path certificates,
  * `<openssl-binary>` => Status for a specific openssl installation,
  * `all`       => Status of all installed Rubies certificate paths.
* `update`      => Update SSL certificates for current Ruby,
  * `<ruby>`    => Update a specific Ruby certificates,
  * `<certs-path>`     => Update certificates in a specific path,
  * `<openssl-binary>` => Update certificates for a specific openssl installation,
  * `all`       => Update all installed Rubies certificate paths.
* `cron`        => Manage cron job for daily updates,
  * `status`    => Show if the cron job is installed,
  * `install`   => Install the cron job,
  * `uninstall` => Uninstall the cron job.

## Examples

Show the status for all installed rubies:

    rvm osx-ssl-certs status all

Update OpenSSL certificates for current ruby:

    rvm osx-ssl-certs update

Update OpenSSL certificates for specific path:

    rvm osx-ssl-certs update /etc/openssl

Schedule daily update of certificates:

    rvm osx-ssl-certs cron install

## Troubleshooting

If the `status` argument returns that all is good and you still get errors, it's probably caused by bad certificate chain on the server.

To troubleshoot you can check the chain with:

```
openssl s_client -showcerts -connect google.com:443
```

Replace `google.com` with your server address

## Reporting bugs

Please report issues to https://github.com/rvm/rvm/issues

In case of security issues use rvm-internal@googlegroups.com
