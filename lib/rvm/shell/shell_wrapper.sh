# Prints an epilog to a shell command.
__rvm_show_command_epilog() {
  local last_command_result="$?"
  echo "---------------RVM-RESULTS-START---------------"
  echo "---"
  echo " exit_status: \"$last_command_result\""
  echo " environment:"
  env | sed "s#'#\\'#" | sed -e 's#"#\\"#' -e "s#\\([^=]*\\)=\\(.*\\)#   '\1': \"\2\"#"
  echo "----------------RVM-RESULTS-END----------------"
}
