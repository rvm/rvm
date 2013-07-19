source "$rvm_path/scripts/rvm"

: setup
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-rvmrc
mkdir -p $d/.bundle
cd $d

: test BUNDLE_BIN not set
source "$rvm_path/hooks/after_cd_bundler"
[[ -z "$LAST_BUNDLER_BIN_PATH" ]]
# status=0

: test BUNDLE_BIN full path
echo 'BUNDLE_BIN: /full/path' > .bundle/config
source "$rvm_path/hooks/after_cd_bundler"
[[ "$LAST_BUNDLER_BIN_PATH" == "/full/path" ]]
# status=0

: test BUNDLE_BIN with ~
echo 'BUNDLE_BIN: ~/binstubs' > .bundle/config
source "$rvm_path/hooks/after_cd_bundler"
[[ "$LAST_BUNDLER_BIN_PATH" == "$HOME/binstubs" ]]
# status=0

: test BUNDLE_BIN with $HOME
echo 'BUNDLE_BIN: $HOME/binstubs' > .bundle/config
source "$rvm_path/hooks/after_cd_bundler"
[[ "$LAST_BUNDLER_BIN_PATH" == "$HOME/binstubs" ]]
# status=0

: test BUNDLE_BIN relative
echo 'BUNDLE_BIN: bin/' > .bundle/config
source "$rvm_path/hooks/after_cd_bundler" <<<Yes
[[ "$LAST_BUNDLER_BIN_PATH" == "$PWD/bin/" ]]
# status=0

: cleanup
rm -rf $d
