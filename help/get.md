# rvm get

Update RVM

## Usage

  rvm get {stable|latest|latest-x.y|x.y.z|head|master|branch|help} [--auto-dotfiles] [--autolibs=X]

## Options

  stable     - install the latest RVM stable release

  latest     - install the latest RVM release

  latest-minor
             - install the latest minor RVM release for currently installed version

  latest-x.y - install the latest RVM release matching the x.y* pattern

  x.y.z      - install a specific RVM release

  head
  master     - install the latest RVM development version

  --auto-dotfiles
             - automatically update shell profile files.

  --autolibs=X
             - update autolibs mode to `X`, read more: `rvm autolibs`

  help       - Output this message.

## Branches

    branch <branch>
    branch /<branch>
    branch <repo>/
    branch <repo>/<branch>

## Defaults

    branch: master
    repo:   rvm

## Examples

    rvm get branch shoes   # will fetch branch shoes  from rvm/rvm repo
    rvm get branch mpapis/ # will fetch branch master from mpapis/rvm       repo
