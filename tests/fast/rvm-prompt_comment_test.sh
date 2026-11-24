source "$rvm_path/scripts/rvm"

command rvm install 3.3.12
command rvm install 3.4.12
command rvm install 3.3.13

rvm 1.9.1 do rvm-prompt      # match=/Ruby (ruby-)?1.9.1(-p[[:digit:]]+)? is not installed./
rvm 3.4.12 do rvm-prompt      # match=/^ruby-3.4.12$/
rvm 3.3.13 do rvm-prompt i    # match=/^ruby$/
rvm 3.3.13 do rvm-prompt i v  # match=/^ruby-3.3.13$/
rvm 3.3.13 do rvm-prompt v    # match=/^3.3.13$/
rvm system do rvm-prompt     # match=/^$/
rvm system do rvm-prompt s v # match=/^system$/
rvm 3.3.12 do rvm-prompt s v  # match=/^3.3.12$/
