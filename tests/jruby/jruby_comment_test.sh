rvm install jruby        # status=0; match!=/Already installed/
rvm jruby do ruby -v     # match=/jruby/; match=/OpenJDK/
rvm remove jruby         # status=0; match=/Removing/
