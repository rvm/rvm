source "$rvm_path/scripts/rvm"

rvm remove  1.8.7-p374-ntest --gems

## without gemsets

rvm install 1.8.7-p374-ntest --skip-gemsets --disable-binary
# status=0
# match!=/Already installed/
# match=/Skipped importing default gemsets/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm install 1.8.7-p374-ntest
# status=0; match=/Already installed/

rvm 1.8.7-p374-ntest do which gem
# match=/1.8.7-p374-ntest/

rvm 1.8.7-p374-ntest do gem env

rvm 1.8.7-p374-ntest do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/rubygems-bundler/

rvm 1.8.7-p374-ntest do ruby -v
# match=/1.8.7.*patchlevel 374/

rvm remove  1.8.7-p374-ntest --gems
# status=0; match=/[Rr]emoving/


## default/global gemsets

mkdir -p $rvm_path/gemsets/ruby/1.8.7/p374/
printf "gem-wrappers\ntf\n"   > $rvm_path/gemsets/ruby/1.8.7/p374/global.gems
printf "gem-wrappers\nhaml -v <5\n" > $rvm_path/gemsets/ruby/1.8.7/p374/default.gems

rvm install 1.8.7-p374-ntest
# status=0
# match!=/Already installed/
# match=/importing gemset .*gemsets\/ruby\/1.8.7\/p374\/global.gems/
# match=/importing gemset .*gemsets\/ruby\/1.8.7\/p374\/default.gems/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm 1.8.7-p374-ntest do gem list
# match[stderr]=/\A\Z/
# match[stdout]=/haml/
# match[stdout]=/tf/

rvm 1.8.7-p374-ntest@global do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/haml/
# match[stdout]=/tf/

## Cleanup

rvm remove 1.8.7-p374-ntest --gems
# status=0; match=/[Rr]emoving/

rm -rf $rvm_path/gemsets/ruby/1.8.7/p374

ls -1d $rvm_path/environments/*1.8.7-p374-ntest*   # status!=0
ls -1d $rvm_path/wrappers/*1.8.7-p374-ntest*       # status!=0
ls -1d $rvm_path/gems/*1.8.7-p374-ntest*           # status!=0
ls -1d $rvm_path/bin/*1.8.7-p374-ntest*            # status!=0

