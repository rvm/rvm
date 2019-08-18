rvm install truffleruby # status=0; match!=/Already installed/; match=/compiling c-extensions/
rvm truffleruby do ruby -v # status=0; match=/truffleruby/
rvm truffleruby do rake --version # status=0; match=/rake, version/
rvm truffleruby do ruby -ropen-uri -e 'puts open("https://rubygems.org/") { |f| f.read(1024) }'
# status=0; match=/RubyGems.org/
rvm remove truffleruby # status=0; match=/removing.+truffleruby/

## Test that the right version is installed (#4633)
rvm install truffleruby-1.0.0-rc13 # status=0; match!=/Already installed/
rvm truffleruby-1.0.0-rc13 do ruby -v # status=0; match=/truffleruby 1.0.0-rc13/
rvm remove truffleruby-1.0.0-rc13
