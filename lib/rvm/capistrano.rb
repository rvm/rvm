# Recipes for using RVM on a server with capistrano.

raise "RVM - Capistrano integration was extracted to a separate gem, \
install: `gem install rvm-capistrano` and remove the `$LOAD_PATH.unshift` line, \
note also the 'set :rvm_type, :user' is now the default (instead of :system)."
