source "$rvm_path/scripts/rvm"

: prepare
true TMPDIR:${TMPDIR:=/tmp}:
d=$TMPDIR/test-wrappers
mkdir $d
pushd $d
rvm install 3.0.5 # status=0
rvm use --install 2.6.6 # status=0
rvm 2.6.6@global do gem install rake -v "<10.2"

: help
rvm wrapper      # status!=0; match=/Usage/
rvm wrapper help # status=0;  match=/Usage/

: show
rvm wrapper show
# status=0
# match=/Wrappers path: .*/gems/ruby-2.6.6\/wrappers/
# match=/Environment file: .*/gems/ruby-2.6.6/environment/
# match=/Executables: .*, rake, /

: show rake
rvm wrapper show rake
# status=0
# match=/.*/gems/ruby-2.6.6\/wrappers\/rake/

: for file
echo 'echo "$GEM_HOME"' > $d/custom-script
chmod +x $d/custom-script
rvm 3.0.5 do rvm wrapper $d/custom-script # status=0
wrapper_script=`rvm 3.0.5 do rvm wrapper show custom-script`
# status=0
# env[wrapper_script]=/.*/gems/ruby-3.0.5\/wrappers\/custom-script/
$wrapper_script
# status=0
# match=/.*/gems/ruby-3.0.5\Z/
# env[GEM_HOME]=/.*/gems/ruby-2.6.6\Z/

: regenerate
rm -f $GEM_HOME/wrappers/rake
rvm wrapper show rake   # status!=0
rvm wrapper regenerate  # status=0
rvm wrapper show rake   # status=0

: clean
popd
rm -rf $d
