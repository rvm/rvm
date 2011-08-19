#!/usr/bin/env bash

########################################################################
TEST_CASE=$(basename "$0")
########################################################################
. ${0%/$TEST_CASE}/../../test_helper.sh
initialize_rvm

test_match_exits_zero_if_input_matches_the_pattern () {
  match "a" "a"
  assert_status_equal 0 $? $LINENO

  match "snark" "a"
  assert_status_equal 0 $? $LINENO

  match "snark" "^s"
  assert_status_equal 0 $? $LINENO

  match "snark" "k$"
  assert_status_equal 0 $? $LINENO

  match "snark" "s$"
  assert_status_equal 1 $? $LINENO

  match "snark" "^k"
  assert_status_equal 1 $? $LINENO

  match "1.9.1" "[0-9]\.[0-9]*"
  assert_status_equal 0 $? $LINENO

  match "snark.rb" "*\.rb$"
  assert_status_equal 0 $? $LINENO

  match "snark.gems" "*\.gems$"
  assert_status_equal 0 $? $LINENO

  match "snark.gem" "*\.gem$"
  assert_status_equal 0 $? $LINENO

  match "1.9.1${rvm_gemset_separator:-"@"}snark" "*${rvm_gemset_separator:-"@"}*"
  assert_status_equal 0 $? $LINENO

  match "1.9.1" "*${rvm_gemset_separator:-"@"}*"
  assert_status_equal 1 $? $LINENO
}

run_test_case "$0"
