rvm reinstall 1.8.7-ntest -C --program-suffix=1.8 # status=0; match=/linking ruby1.8 -> ruby/; match=/linking gem1.8 -> gem/

rvm 1.8.7-ntest do ruby1.8 -v  # match=/1.8.7/
rvm remove 1.8.7-ntest         # status=0; match=/Removing/
