source "$rvm_path/scripts/rvm"

: duplicate and trailing slashes are removed without depending on system detection, see issues 1364 and 4618
( unset _system_type ; PATH="/usr//bin/:/bin//:/usr/sbin/" ; __rvm_remove_from_path /nonexistent ; echo "$PATH" ) 2>&1 # status=0; match=/^/usr/bin:/bin:/usr/sbin$/; match!=/illegal option/

: root entries are kept, an empty entry would add the current directory to PATH
( PATH="/:/usr/bin:/:/bin" ; __rvm_remove_from_path /nonexistent ; echo "$PATH" ) # match=/^/:/usr/bin:/:/bin$/

: entries are removed regardless of trailing slashes
( PATH="/usr/bin:/opt/rvm-test/bin/:/bin:/opt/rvm-test/bin/" ; __rvm_remove_from_path /opt/rvm-test/bin ; echo "$PATH" ) # match=/^/usr/bin:/bin$/
( PATH="/usr/bin:/opt/rvm-test/bin:/bin" ; __rvm_remove_from_path /opt/rvm-test/bin/ ; echo "$PATH" ) # match=/^/usr/bin:/bin$/

: removing the whole PATH is refused, see issue 4759
( PATH="/usr/bin:/bin" ; __rvm_remove_from_path "/*" ; echo "$PATH" ) # match=/^/usr/bin:/bin$/
( PATH="/usr/bin:/bin" ; __rvm_remove_from_path "//*" ; echo "$PATH" ) # match=/^/usr/bin:/bin$/
