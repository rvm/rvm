# Fetch

Performs an archive / src fetch of the current selected ruby.

## Usage

    $ rvm fetch [--verify-downloads {0,1,2}]

Where `--verify-downloads {0,1,2}` specifies verification level:

- `0` - only verified allowed - the default,
- `1` - allow missing checksum,
- `2` - allow failed checksum.
