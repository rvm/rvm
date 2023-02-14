source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-ruby-version
f=$d/.ruby-version
g=$d/.ruby-gemset
e=$d/.ruby-env
mkdir -p $d
cd $d
rvm use --install 2.4.1
rvm use --install 3.0.5
rvm use --install 3.1.3

## simple
: short version
echo "3.0.5" > $f           # env[GEM_HOME]=/3.1.3/
rvm use .                   # env[GEM_HOME]=/3.0.5/

: ruby version
rvm use 3.1.3
echo "ruby-3.0.5" > $f      # env[GEM_HOME]=/3.1.3/
rvm use .                   # env[GEM_HOME]=/3.0.5/

: patch version
rvm use 3.1.3
echo "2.4.1" > $f      # env[GEM_HOME]=/3.1.3/
rvm use .                   # env[GEM_HOME]=/2.4.1/

: full version
rvm use 3.1.3
echo "ruby-2.4.1" > $f # env[GEM_HOME]=/3.1.3/
rvm use .                   # env[GEM_HOME]=/2.4.1/

: gemset
rvm use 3.1.3
echo "veve" > $g            # env[GEM_HOME]=/3.1.3/
rvm use .                   # env[GEM_HOME]=/2.4.1@veve/
rm -f $g

: environment
rvm use 3.1.3
echo "test_me=3" > $e
rvm use .                   # env[GEM_HOME]=/2.4.1/; env[test_me]=/^3$/
rvm use 3.1.3               # env[GEM_HOME]=/2.6.6/; env[test_me]=/^$/

: environment spaces
rvm use 3.1.3
echo 'test_space=test me' > $e
rvm use .                   # env[GEM_HOME]=/2.4.1/; env[test_space]=/^test me$/
rvm use 3.1.3               # env[GEM_HOME]=/2.6.6/; env[test_space]=/^$/

: environment quotes and spaces
rvm use 3.1.3
echo 'test_space="test me"' > $e
rvm use .                   # env[GEM_HOME]=/2.4.1/; env[test_space]=/^test me$/
rvm use 3.1.3               # env[GEM_HOME]=/2.6.6/; env[test_space]=/^$/

: clean
cd ..
rm -rf $d
