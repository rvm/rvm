source "$rvm_path/scripts/rvm"

rvm try_install 3.0.5
rvm try_install 3.1.3
rvm try_install 3.1.2

: separate default/current
rvm use 3.0.5@abc-test --create --default
# status=0
# match=/Using .*ruby-3.0.5 with gemset abc-test/
rvm current
# match=/ruby-3.0.5@abc-test/

rvm use 3.1.3@abc-test --create
# status=0
# match=/Using .*ruby-3.1.3 with gemset abc-test/
rvm current
# match=/ruby-3.1.3@abc-test/

rvm list
# match=/^ \* ruby-3.0.5/
# match=/^=> ruby-3.1.3/

: default == current
rvm use 3.1.2@abc-test --create --default
# status=0
# match=/Using .*ruby-3.1.2 with gemset abc-test/
rvm current
# match=/ruby-3.1.2@abc-test/

rvm list
# match=/^=\* ruby-3.1.2/
