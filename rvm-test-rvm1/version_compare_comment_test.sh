source "$rvm_path/scripts/rvm"

: numbers
__rvm_version_compare 1 ==  1 # status=0
__rvm_version_compare 2 \>  1 # status=0
__rvm_version_compare 2 \>= 1 # status=0
__rvm_version_compare 2 \>= 2 # status=0
__rvm_version_compare 1 \<  2 # status=0
__rvm_version_compare 1 \<= 2 # status=0
__rvm_version_compare 2 \<= 2 # status=0
__rvm_version_compare 1 !=  1 # status=1
__rvm_version_compare 1 \<  1 # status=1
__rvm_version_compare 2 \<  1 # status=1
__rvm_version_compare 2 \<= 1 # status=1
__rvm_version_compare 1 \>  1 # status=1
__rvm_version_compare 1 \>  2 # status=1
__rvm_version_compare 1 \>= 2 # status=1
