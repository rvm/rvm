source "$rvm_path/scripts/base"
source "$rvm_path/scripts/functions/rubygems"

rvm_ruby_string=ruby-1.9.2-p330; rvm_ruby_interpreter=ruby; rvm_ruby_version=1.9.2; version=latest; rubygems_select_current; printf "%s\n" "$version" # match=/^2\.7\.9$/
rvm_ruby_string=ruby-1.9.3-p551; rvm_ruby_interpreter=ruby; rvm_ruby_version=1.9.3; version=latest; rubygems_select_current; printf "%s\n" "$version" # match=/^2\.7\.9$/
