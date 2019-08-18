rvm use 1.9.3
rvm reinstall rbx-ntest --19 # status=0; match!=/Already installed/
rvm rbx-ntest do ruby -v     # match=/1.9./; match=/rubinius/
rvm remove rbx-ntest         # status=0; match=/Removing/
