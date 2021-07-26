source "$rvm_path/scripts/rvm"

rvm remove  2.6.5-ntest --gems

## without gemsets

rvm install 2.6.5-ntest --skip-gemsets --disable-binary
# status=0
# match!=/Already installed/
# match=/Skipped importing default gemsets/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm install 2.6.5-ntest
# status=0; match=/Already installed/

rvm 2.6.5-ntest do which gem
# match=/2.6.5-ntest/

rvm 2.6.5-ntest do gem env

rvm 2.6.5-ntest do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/rubygems-bundler/

rvm 2.6.5-ntest do ruby -v
# match=/2.6.5/

rvm remove  2.6.5-ntest --gems
# status=0; match=/[Rr]emoving/


## default/global gemsets

mkdir -p $rvm_path/gemsets/ruby/2.6.5/
printf "gem-wrappers\ntf\n"   > $rvm_path/gemsets/ruby/2.6.5/global.gems
printf "gem-wrappers\nhaml -v <5\n" > $rvm_path/gemsets/ruby/2.6.5/default.gems

rvm install 2.6.5-ntest
# status=0
# match!=/Already installed/
# match=/importing gemset .*gemsets\/ruby\/2.6.5\/global.gems/
# match=/importing gemset .*gemsets\/ruby\/2.6.5\/default.gems/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm 2.6.5-ntest do gem list
# match[stderr]=/\A\Z/
# match[stdout]=/haml/
# match[stdout]=/tf/

rvm 2.6.5-ntest@global do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/haml/
# match[stdout]=/tf/

## Cleanup

rvm remove 2.6.5-ntest --gems
# status=0; match=/[Rr]emoving/

rm -rf $rvm_path/gemsets/ruby/2.6.5

ls -1d $rvm_path/environments/*2.6.5-ntest*   # status!=0
ls -1d $rvm_path/wrappers/*2.6.5-ntest*       # status!=0
ls -1d $rvm_path/gems/*2.6.5-ntest*           # status!=0
ls -1d $rvm_path/bin/*2.6.5-ntest*            # status!=0

