source "$rvm_path/scripts/rvm"

: system details are unset after every command, lookups detect them again, see issue 4618
( unset _system_type _system_name _system_version ; __rvm_db_system ruby_version __rvm_test_value ; echo "${_system_type:-none}" ) # match=/^(Linux|Darwin)$/

: the cd hook uses system specific settings, CentOS 5 is simulated with a user db override
bash -c 'db="$rvm_path/user/db" ; d="$(mktemp -d)" ; touch "$db" ; cp "$db" "$d/db.bak" ; trap "mv -f \"$d/db.bak\" \"$db\" ; rm -rf \"$d\"" EXIT ; printf "system_name=CentOS\nsystem_version=5\n" >> "$db" ; mkdir "$d/proj" ; echo 1.8.7 > "$d/proj/.ruby-version" ; source "$rvm_path/scripts/rvm" ; cd "$d/proj"' 2>&1 # match=/ruby-1.8.7-p374/; match!=/ruby-1.8.7-head/
