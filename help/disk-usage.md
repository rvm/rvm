## Usage

    rvm disk-usage {all,total,archives,docs,repos,sources,logs,pkg,rubies,gemsets,wrappers,tmp,others}'

Shows the amount of disk space used by a specific set of data associated with rvm.
`all` returns each, individually, along with the total space used.

## Examples:

To find out how much space your rvm install is using, simply run:

    rvm disk-usage all

To find out how much space only your gemsets use, run:

    rvm disk-usage gemsets
