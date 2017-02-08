# RVM 2.0 work announcement

Work on RVM 2.0 has started, check the plan here:
https://docs.google.com/document/d/1xW9GeEpLOWPcddDg_hOPvK4oeLxJmU3Q5FiCNT7nTAc/edit?usp=sharing

To be able to do the RVM 2.0 work we need to stop working on RVM 1.x -
this means no more feature requests will be accepted.
Development on RVM 1.x will continue to provide bugfixes and
support for new ruby versions as long as RVM 2.0 will not become stable.
RVM is an open source project so any contributions are welcome -
including new features pull requests - as long as they keep compatibility and
do not break anything.

# Common workflows

## Adding support for new version of Ruby
 
Following files needs to be updated to add support for a new version of already supported Ruby interpreter.
Please follow patterns used in those files and add entries in appropriate location. 
[\#3805](https://github.com/rvm/rvm/commit/c5845cf75f030f8e881e6ab3554dee4f9cc72b46) contains good example of the required changes.

* `config/known`
  * update existing entry when minor version released 
  * add new entry when major version released
* `config/known_strings` - same rules as above
* `config/db` - update only for stable releases
* `config/md5` - add new line with `md5` hash of the interpreter source
* `config/sha512` - add new line with `sha512` hash of the interpreter source

When listing interpreter source make sure that you link to the smallest archive variant (usually `.bz2`).

When release package does not include `md5` or `sha512` hashes you should download the source package and calculate it yourself.
One of the ways to do that would be to use `openssl` command:

```
openssl dgst -sha512 FILE
openssl dgst -md5 FILE
```

## Running RVM in local development environment

To test a local copy of RVM for development purposes simply enter the folder with the source and install it:
 
```
./install && rvm reload
```

If you don't want to destroy your working environment, you can select a different destination folder and easily switch between them:

```
./install --path ~/.rvm-dev
rvm switch ~/.rvm-dev           # development version
rvm switch ~/.rvm               # production version
```


## Coding guidelines
https://github.com/rvm/rvm/blob/master/FORMATTING.md
