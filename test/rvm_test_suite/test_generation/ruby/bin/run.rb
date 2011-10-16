@current_dir = `PWD`

load "#{@current_dir.strip}/bin/connect.rb"
load "#{@current_dir.strip}/app/models/commands.rb"

@command = Command.new
@command.sysname = `uname -n`.strip
@command.os_type = `uname -s`.strip
@command.cmd = ARGV[0]
@command.cmd_output = `rvm info`
@command.save!

puts "\t\t\t\t*************** [ SYSTEM REPORT FOR #{@command.sysname} ] ***************\t\t\t\t\n\n"
puts " COMMAND ID #: #{@command.id}\n SYSTEM TYPE: #{@command.os_type}\n EXECUTED COMMAND: #{@command.cmd}\n COMMAND OUTPUT: #{@command.cmd_output}"

0.upto(@command.id - 1) {|id| puts "Deleting Record #" + @command.id.to_s ; @command[id].destroy }

