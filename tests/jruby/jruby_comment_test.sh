rvm install jruby        # status=0; match!=/Already installed/
rvm jruby do ruby -v     # match=/1.9./; match=/Java/
rvm remove jruby         # status=0; match=/Removing/
