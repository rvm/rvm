rvm reinstall jruby            # status=0; match!=/Already installed/
rvm jruby-ntest do ruby -v     # match=/1.9./; match=/Java/
rvm remove jruby-ntest         # status=0; match=/Removing/
