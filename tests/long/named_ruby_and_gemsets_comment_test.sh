source "$rvm_path/scripts/rvm"

rvm remove  3.2.1 --gems

## without gemsets

rvm install 3.2.1 --skip-gemsets --disable-binary
# status=0
# match!=/Already installed/
# match=/Skipped importing default gemsets/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm install 3.2.1
# status=0; match=/Already installed/

rvm 3.2.1 do which gem
# match=/3.2.1/

rvm 3.2.1 do gem env

rvm 3.2.1 do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/rubygems-bundler/

rvm 3.2.1 do ruby -v
# match=/3.2.1/

rvm remove  3.2.1 --gems
# status=0; match=/[Rr]emoving/


## default/global gemsets

mkdir -p $rvm_path/gemsets/ruby/3.2.1/
printf "gem-wrappers\ntf\n"   > $rvm_path/gemsets/ruby/3.2.1/global.gems
printf "gem-wrappers\nhaml -v <5\n" > $rvm_path/gemsets/ruby/3.2.1/default.gems

rvm install 3.2.1
# status=0
# match!=/Already installed/
# match=/importing gemset .*gemsets\/ruby\/3.2.1\/global.gems/
# match=/importing gemset .*gemsets\/ruby\/3.2.1\/default.gems/
## match=/WARNING: Please be aware that you just installed a ruby that/
## match=/for a list of maintained rubies visit:/

rvm 3.2.1 do gem list
# match[stderr]=/\A\Z/
# match[stdout]=/haml/
# match[stdout]=/tf/

rvm 3.2.1@global do gem list
# match[stderr]=/\A\Z/
# match[stdout]!=/haml/
# match[stdout]=/tf/

## Cleanup

rvm remove 3.2.1 --gems
# status=0; match=/[Rr]emoving/

rm -rf $rvm_path/gemsets/ruby/3.2.1

ls -1d $rvm_path/environments/*3.2.1*   # status!=0
ls -1d $rvm_path/wrappers/*3.2.1*       # status!=0
ls -1d $rvm_path/gems/*3.2.1*           # status!=0
ls -1d $rvm_path/bin/*3.2.1*            # status!=0

