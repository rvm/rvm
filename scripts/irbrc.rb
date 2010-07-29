# This is the common irbrc file used by all rvm ruby installations.
# This file will be overriden every time you update rvm.

# Turn on completion.
begin
require "readline"
rescue
  puts "Readline was unable to be required, if you need completion or history install readline then reinstall the ruby.\nYou may follow 'rvm notes' for dependencies and/or read the docs page http://rvm.beginrescueend.com/packages/readline/ . Be sure you 'rvm remove X ; rvm install X' to re-compile your ruby with readline support after obtaining the readline libraries."
end
require "irb/completion" rescue nil

# Turn on history saving.
require "irb/ext/save-history"
IRB.conf[:HISTORY_FILE] = File.join(ENV["HOME"], ".irb-history")

# Calculate the ruby string.
rvm_ruby_string = ENV["rvm_ruby_string"] || "#{RUBY_ENGINE rescue 'ruby'}-#{RUBY_VERSION}-#{(RUBY_PATCHLEVEL) ? "p#{RUBY_PATCHLEVEL}" : "r#{RUBY_REVISION}"}"

# Set up the prompt to be RVM specific.
@prompt = {
  :PROMPT_I => "#{rvm_ruby_string} > ",  # default prompt
  :PROMPT_S => "#{rvm_ruby_string}%l> ", # known continuation
  :PROMPT_C => "#{rvm_ruby_string} > ",
  :PROMPT_N => "#{rvm_ruby_string} ?> ", # unknown continuation
  :RETURN => " => %s \n",
  :AUTO_INDENT => true
}
IRB.conf[:PROMPT][:RVM] = @prompt
IRB.conf[:PROMPT_MODE] = :RVM

# Load the user's irbrc file, if possible.
# Report any errors that occur.
begin
  load File.join(ENV["HOME"], ".irbrc") if File.exists?("#{ENV["HOME"]}/.irbrc")
rescue LoadError => load_error
  puts load_error
rescue => exception
  puts "Error : 'load #{ENV["HOME"]}/.irbrc' : #{exception.message}"
end
