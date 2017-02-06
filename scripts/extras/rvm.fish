#!/usr/bin/env fish

function load_env_file
  sed -e "s/export\(.*\);\(.*\)=/set -x \1 /" -e "s/export\(.*\)=/set -x \1 /" -e 's/unset/set -e /' -e "/ PATH / s/[\"':]/ /g" -e 's/$/; /' < $argv | source
end

load_env_file ~/.rvm/environments/default

function rvm
  switch $argv[1]
  case 'use'
    load_env_file (~/.rvm/bin/rvm $argv do rvm env --path | tail -n 1)
  case '*'
    ~/.rvm/bin/rvm $argv
  end
end
