source "$rvm_path/scripts/rvm"

rvm use 3.3.13 --install
rvm use 3.4.12 --install
rvm gemset create test_gemset

rvm alias create default 3.4.12@test_gemset # status=0
ls -l $rvm_path/environments/default       # status=0; match=/3.4.12@test_gemset/
rvm alias list                             # match=/^default => ruby-3.4.12@test_gemset$/
rvm alias delete default                   # status=0
ls -l $rvm_path/environments/default       # status!=0

rvm alias create ruby-test-default 3.4.12@test_gemset # status=0
ls -l $rvm_path/environments/ruby-test-default       # status=0
rvm alias list                                       # match=/^ruby-test-default => ruby-3.4.12@test_gemset$/
rvm alias list names                                 # match=/^ruby-test-default$/
rvm alias delete ruby-test-default                   # status=0
ls -l $rvm_path/environments/ruby-test-default       # status!=0

rvm --force gemset delete test_gemset

: overwrite existing aliases
rvm alias create veve 3.3.13  # status=0
ls -l $rvm_path/environments/veve # status=0; match=/3.3.13/
ls -l $rvm_path/wrappers/veve     # status=0; match=/3.3.13/
rvm alias list                    # match=/^veve => ruby-3.3.13$/
rvm alias create veve 3.4.12       # status=0
ls -l $rvm_path/environments/veve # status=0; match=/3.4.12/
ls -l $rvm_path/wrappers/veve     # status=0; match=/3.4.12/
rvm alias list                    # match=/^veve => ruby-3.4.12$/
rvm alias delete veve             # status=0
ls -l $rvm_path/environments/veve # status!=0
rvm alias list                    # match!=/^veve => /
