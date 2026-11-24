source "$rvm_path/scripts/rvm"

rvm try_install 3.4.12
rvm try_install 3.3.13
rvm try_install 3.3.12

: separate default/current
rvm use 3.4.12@abc-test --create --default
# status=0
# match=/Using .*ruby-3.4.12 with gemset abc-test/
rvm current
# match=/ruby-3.4.12@abc-test/

rvm use 3.3.13@abc-test --create
# status=0
# match=/Using .*ruby-3.3.13 with gemset abc-test/
rvm current
# match=/ruby-3.3.13@abc-test/

rvm list
# match=/^ \* ruby-3.4.12/
# match=/^=> ruby-3.3.13/

: default == current
rvm use 3.3.12@abc-test --create --default
# status=0
# match=/Using .*ruby-3.3.12 with gemset abc-test/
rvm current
# match=/ruby-3.3.12@abc-test/

rvm list
# match=/^=\* ruby-3.3.12/
