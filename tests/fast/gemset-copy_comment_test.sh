source "$rvm_path/scripts/rvm"

rvm use 3.4.12 --install

:
rvm gemset copy 3.4.12 3.4.12@testset # status=0; match=/Copying gemset/; match[stderr]=/^$/
rvm gemset list                     # status=0; match=/ testset$/
rvm gemset --force delete testset   # status=0; match=/Removing gemset testset/
rvm gemset list                     # status=0; match!=/ testset$/
