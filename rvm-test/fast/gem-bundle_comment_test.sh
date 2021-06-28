source "$rvm_path/scripts/rvm"

: setup/pretest
export BUNDLE_GEMFILE=${TMPDIR:-/tmp}/Gemfile
touch ${BUNDLE_GEMFILE}
rvm alias delete default
rvm use 2.4 --fuzzy --install
rvm @global do gem uninstall bundler ## newest rubygems comes with bundler as default, can not uninstall
# match=/ERROR:  While executing gem ... \(Gem::InstallError\)/
# match=/gem "bundler" cannot be uninstalled because it is a default gem/

: test
bundle config # status=0 ; match=/Settings are listed in order of priority/

: cleanup
rm -f ${BUNDLE_GEMFILE}
