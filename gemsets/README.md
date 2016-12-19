It is important to keep `default.gems` and `global.gems` even empty to
trigger automatic addition of gems to this files.

Every type of ruby, version and patchlevel can have its own file for
`default.gems` or `global.gems`. The longest path takes precedence and
overwrites previous files, the files are not merged to allow removing
gems from installation.
