source "$rvm_path/scripts/rvm"

rvm use 3.4.12 --install

rvm env 3.4.12           # match=/3.4.12/; match=/GEM_HOME=/; match=/GEM_PATH=/
rvm env 3.4.12 --path    # match=/3.4.12/; match=/environments/
rvm env 3.4.12 -- --path # match=/3.4.12/; match=/environments/
