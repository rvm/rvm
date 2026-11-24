source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-ruby-version
f=$d/.ruby-version
g=$d/.ruby-gemset
e=$d/.ruby-env
mkdir -p $d
cd $d
rvm use --install 3.3.12
rvm use --install 3.4.12
rvm use --install 3.3.13

## simple
: short version
echo "3.4.12" > $f           # env[GEM_HOME]=/3.3.13/
rvm use .                   # env[GEM_HOME]=/3.4.12/

: ruby version
rvm use 3.3.13
echo "ruby-3.4.12" > $f      # env[GEM_HOME]=/3.3.13/
rvm use .                   # env[GEM_HOME]=/3.4.12/

: patch version
rvm use 3.3.13
echo "3.3.12" > $f      # env[GEM_HOME]=/3.3.13/
rvm use .                   # env[GEM_HOME]=/3.3.12/

: full version
rvm use 3.3.13
echo "ruby-3.3.12" > $f # env[GEM_HOME]=/3.3.13/
rvm use .                   # env[GEM_HOME]=/3.3.12/

: gemset
rvm use 3.3.13
echo "veve" > $g            # env[GEM_HOME]=/3.3.13/
rvm use .                   # env[GEM_HOME]=/3.3.12@veve/
rm -f $g

: environment
rvm use 3.3.13
echo "test_me=3" > $e
rvm use .                   # env[GEM_HOME]=/3.3.12/; env[test_me]=/^3$/
rvm use 3.3.13               # env[GEM_HOME]=/3.3.13/; env[test_me]=/^$/

: environment spaces
rvm use 3.3.13
echo 'test_space=test me' > $e
rvm use .                   # env[GEM_HOME]=/3.3.12/; env[test_space]=/^test me$/
rvm use 3.3.13               # env[GEM_HOME]=/3.3.13/; env[test_space]=/^$/

: environment quotes and spaces
rvm use 3.3.13
echo 'test_space="test me"' > $e
rvm use .                   # env[GEM_HOME]=/3.3.12/; env[test_space]=/^test me$/
rvm use 3.3.13               # env[GEM_HOME]=/3.3.13/; env[test_space]=/^$/

: clean
cd ..
rm -rf $d
