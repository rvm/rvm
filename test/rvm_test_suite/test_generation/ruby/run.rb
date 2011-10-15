load 'connect.rb'
load 'app/models/commands.rb'

@command = Command.new
@command.sysname = `uname -n`.strip
@command.os_type = `uname -s`.strip
@command.cmd = "rvm info"
@command.cmd_output = `rvm info`
@command.save!

puts "**************[ SYSTEM REPORT FOR #{@command.sysname} ]***************\n\n"
puts " SYSTEM TYPE: #{@command.os_type}\n EXECUTED COMMAND: #{@command.cmd}\n COMMAND OUTPUT: #{@command.cmd_output}"

