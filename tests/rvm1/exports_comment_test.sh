source "$rvm_path/scripts/rvm"

export TEST_VAR=2     # env[TEST_VAR]=/^2$/; env[rvm_old_TEST_VAR]=/^$/
rvm export TEST_VAR=3 # env[TEST_VAR]=/^3$/; env[rvm_old_TEST_VAR]=/^2$/
rvm unexport          # env[TEST_VAR]=/^2$/; env[rvm_old_TEST_VAR]=/^$/

unset TEST_VAR        # env[TEST_VAR]=/^$/
rvm export TEST_VAR=3 # env[TEST_VAR]=/^3$/
rvm unexport          # env[TEST_VAR]=/^$/
