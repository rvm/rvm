bash -u -c 'unset GEM_HOME GEM_PATH MY_RUBY_HOME; export rvm_path="$PWD"; source scripts/rvm >/dev/null; rvm current' # match=/^system$/
bash -u -c 'export rvm_path="$PWD" rvm_scripts_path="$PWD/scripts" rvm_user_path="$PWD/user"; source scripts/base >/dev/null; unset _system_name _system_version; __rvm_db_system ruby_version' # match=/^[0-9]+\.[0-9]+\.[0-9]+$/
