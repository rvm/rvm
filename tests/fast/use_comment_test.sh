source "$rvm_path/scripts/rvm"

command rvm install 3.3.13
command rvm install 3.4.12

rvm use 8.9.9           # status=1; match!=/Using /; env[GEM_HOME]!=/8.9.9/ ; match=/Unknown ruby interpreter version/
rvm reset               # env[GEM_HOME]=/^$/
rvm current             # match=/system/
rvm use 3.3.13      # status=0; match=/Using / ; env[GEM_HOME]=/3.3.13/
rvm current             # match=/3.3.13/
command rvm use 3.4.12   # status=0; match!=/Using /; env[GEM_HOME]!=/3.4.12/ ; match=/RVM is not a function/
rvm use 3.4.12           # status=0; match=/Using / ; env[GEM_HOME]=/3.4.12/
rvm use 1.9.1           # status=1; env[rvm_recommended_ruby]=/rvm install ruby-1.9.1/
