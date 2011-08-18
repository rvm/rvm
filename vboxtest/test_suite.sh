#!/bin/bash
############################################################################
cd "${0%/$(basename $0)}/.."

results_file=${RESULTS_FILE:-results}
messages_file=${MESSAGES_FILE:-messages}

usage="usage: %s [-R RESULTS_FILE] [-M MESSAGES_FILE] [-h]\n"
option="       %s   %s\n"
while getopts "R:M:h" opt
do
  case $opt in
  R  )  results_file=$OPTARG ;;
  M  )  messages_file=$OPTARG ;;
  h  )  printf "$usage" $0
        printf "$option" "-R" "results file"
        printf "$option" "-M" "messages file"
        printf "$option" "-h" "prints this help"
        exit 0 ;;
  \? )  printf "$usage" $0
        exit 2 ;;
  esac
done
shift $(($OPTIND - 1))

############################################################################

#
#  Run the test cases
#

echo "Started on $(hostname)"
START_TIME=$SECONDS

# A portable and efficient way of running these tests with find (see
# http://content.hccfl.edu/pollock/unix/findcmd.htm#exec)
find "$(pwd)/vboxtest/test" -name '*_test.sh' -type f -exec sh -c '
  for test_case in "$@"
  do "$test_case"
  done
' X '{}' + 2>>"$messages_file" | tee -a "$results_file"

END_TIME=$SECONDS
echo
echo "Finished in $(($END_TIME - $START_TIME))s"

if [ -f "$messages_file" ] && [ -f "$results_file" ]
then
  # A helper function to count the number of occurences of a character in a string.
  count_char () {
    grep -o "$1" "$2" | wc -l | tr -d " "
  }

  echo
  cat "$messages_file"
  echo "$(count_char "\." "$results_file") pass, $(count_char "F" "$results_file") fail"
  rm "$messages_file" "$results_file"
fi
