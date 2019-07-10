REPOS=(
  bundler-unload
  executable-hooks
  gem-empty
  gem-wrappers
  rubygems-bundler
  rvm
  rvm-capistrano
  rvm-with
  rvm1-capistrano3
  rvm2
  rvm2-shell
  rvm2-ui
  tf
  pluginator
)

\typeset repo owner
\typeset -a params
params=()

if
  [[ $# -gt 0 ]]
then
  for owner in "$@"
  do
    params+=( --add "$owner" )
  done
fi

for repo in "${REPOS[@]}"
do
  gem owner "$repo" "${params[@]}"
done
