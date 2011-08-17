#!/bin/bash

#
#  Test Suite Setup
#

RESULTS=results
MESSAGES=messages

# A helper function to count the number of occurences of a character in a string.
count_char () {
  grep -o "$1" "$2" | wc -l | tr -d " "
}

#
#  Run the test cases
#

echo "Started on $(hostname)"
START_TIME=$SECONDS

# A portable and efficient way of running these tests with find (see
# http://content.hccfl.edu/pollock/unix/findcmd.htm#exec)
find "$(dirname $0)/test" -name '*_test.sh' -type f -exec sh -c '
  for test_case in "$@"
  do "$test_case"
  done
' X '{}' + 2>>"$MESSAGES" | tee -a "$RESULTS"

END_TIME=$SECONDS
echo
echo "Finished in $(($END_TIME - $START_TIME))s"

if [ -f "$MESSAGES" ] && [ -f "$RESULTS" ]
then
  echo
  cat "$MESSAGES"
  echo "$(count_char "\." "$RESULTS") pass, $(count_char "F" "$RESULTS") fail"
  rm "$MESSAGES" "$RESULTS"
fi
