source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-wrappers
mkdir $d
pushd $d
rvm install 3.4.12 # status=0
rvm use --install 3.3.13 # status=0
rvm 3.3.13@global do gem install rake -v "<10.2" # status=0

: help
rvm wrapper      # status!=0; match=/Usage/
rvm wrapper help # status=0;  match=/Usage/

: show
rvm wrapper show
# status=0
# match=/Wrappers path: .*/gems/ruby-3.3.13\/wrappers/
# match=/Environment file: .*/gems/ruby-3.3.13/environment/
# match=/Executables: .*, rake, /

: show rake
rvm wrapper show rake
# status=0
# match=/.*/gems/ruby-3.3.13\/wrappers\/rake/

: for file
echo 'echo "$GEM_HOME"' > $d/custom-script
chmod +x $d/custom-script
rvm 3.4.12 do rvm wrapper $d/custom-script # status=0
wrapper_script=`rvm 3.4.12 do rvm wrapper show custom-script`
# status=0
# env[wrapper_script]=/.*/gems/ruby-3.4.12\/wrappers\/custom-script/
$wrapper_script
# status=0
# match=/.*/gems/ruby-3.4.12\Z/
# env[GEM_HOME]=/.*/gems/ruby-3.3.13\Z/

: regenerate
rm -f $GEM_HOME/wrappers/rake
rvm wrapper show rake   # status!=0
rvm wrapper regenerate  # status=0
rvm wrapper show rake   # status=0

: clean
popd
rm -rf $d
