# This is the common irbrc file used by all rvm ruby installations.
# This file will be overriden every time you update rvm.

# Calculate the ruby string.
rvm_ruby_string = ENV["rvm_ruby_string"] ||
  (
    ENV['GEM_HOME'] &&
    ( path = ( File.realpath(ENV['GEM_HOME'].to_s) rescue nil ) ) &&
    ( path = $1 if path =~ /(.+)\/$/ ; true ) &&
    String(String(path).split(/\//).last).split(/@/).first
  ) ||
  ("#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}" rescue nil) ||
  (RUBY_DESCRIPTION.split(" ")[1].sub('p', '-p') rescue nil ) ||
  (`ruby -v` || '').split(" ")[1].sub('p', '-p')

# cut ruby- ... everyone knows it's ruby
rvm_ruby_string = $1 if rvm_ruby_string =~ /^ruby[- ](.*)/

# Set up the prompt to be RVM specific.
@prompt = {
  :PROMPT_I => "#{rvm_ruby_string} :%03n > ",  # default prompt
  :PROMPT_S => "#{rvm_ruby_string} :%03n%l> ", # known continuation
  :PROMPT_C => "#{rvm_ruby_string} :%03n > ",
  :PROMPT_N => "#{rvm_ruby_string} :%03n?> ", # unknown continuation
  :RETURN => " => %s \n",
  :AUTO_INDENT => true
}
IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:RVM] = @prompt
IRB.conf[:PROMPT_MODE] = :RVM if IRB.conf[:PROMPT_MODE] == :DEFAULT

require "irb/completion" rescue nil

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = File.join(ENV["HOME"], ".irb-history")

# Load the user's irbrc file, if possible.
# Report any errors that occur.
begin
  load File.join(ENV["HOME"], ".irbrc") if File.exist?("#{ENV["HOME"]}/.irbrc")
rescue LoadError => load_error
  puts load_error
rescue => exception
  puts "Error : 'load #{ENV["HOME"]}/.irbrc' : #{exception.message}"
end
