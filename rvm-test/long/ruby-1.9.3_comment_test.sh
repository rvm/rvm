rvm reinstall 1.9.3-ntest    # status=0; match!=/Already installed/
rvm 1.9.3-ntest do ruby -v   # match=/1.9.3/
rvm 1.9.3-ntest do which gem # match=/1.9.3-p[[:digit:]]+-ntest/
rvm remove 1.9.3-ntest       # status=0; match=/Removing/

