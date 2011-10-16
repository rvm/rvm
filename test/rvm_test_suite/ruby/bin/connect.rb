require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :encoding => "unicode",
  :database => "rvm_testdata_development",
  :pool => "5",
  :username => "me",
  :password => ""
)


