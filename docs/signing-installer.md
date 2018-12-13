# Signing installer

Whenever `binscripts/rvm-installer` is changed it needs to be signed by one of the maintainers:

```bash
gpg --yes --armor --detach-sign binscripts/rvm-installer
```

New signature should be committed to the repo.
