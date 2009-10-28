# This is the common irbrc file used by all rvm ruby installations.
# This file will be overriden every time you update rvm.

# Turn on completion.
require "irb/completion" rescue nil

# Turn on history saving.
require "irb/ext/save-history"
IRB.conf[:HISTORY_FILE] = File.join(ENV['HOME'], ".irb-history")

# Calculate the package name.
RVM_RUBY_PACKAGE_NAME rescue RVM_RUBY_PACKAGE_NAME="ruby-#{RUBY_VERSION}"

# Set up the prompt to be RVM specific.
@prompt = {
  :PROMPT_I => "#{RVM_RUBY_PACKAGE_NAME} > ",  # default prompt
  :PROMPT_S => "#{RVM_RUBY_PACKAGE_NAME}%l> ", # known continuation
  :PROMPT_C => "#{RVM_RUBY_PACKAGE_NAME} > ",
  :PROMPT_N => "#{RVM_RUBY_PACKAGE_NAME} ?> ", # unknown continuation
  :RETURN => " => %s \n",
  :AUTO_INDENT => true
}
IRB.conf[:PROMPT][:RVM] = @prompt
IRB.conf[:PROMPT_MODE] = :RVM

# Load the user's irbrc file, if possible.
load File.join(ENV['HOME'], '.irbrc') rescue nil

# EOF
