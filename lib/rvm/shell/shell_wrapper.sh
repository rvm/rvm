# Prints an epilog to a shell command.
__rvm_show_command_epilog() {
  local last_command_result="$?"
  echo "---------------RVM-RESULTS-START---------------"
  echo " exit_status: \"$last_command_result\""
  echo " environment: $(ruby -rrubygems -ryaml -e 'puts YAML.dump(ENV.inspect)')"
  echo "----------------RVM-RESULTS-END----------------"
  #\env | \sed \
  #  -e "s#'#\\'#g" \
  #  -e 's#"#\\"#g' \
  #  -e "s#\\([^=]*\\)=\\(.*\\)#   '\1': \"\2\"#"
}
