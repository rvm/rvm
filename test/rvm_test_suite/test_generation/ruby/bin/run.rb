# Populate @current_dir so we don't have to always write out the full path
# NOTE: We need a better way of doing this
@current_dir = `PWD`

# Connect to the database using ActiveRecord
load "#{@current_dir.strip}/bin/connect.rb"

# Now load the Model(s)
load "#{@current_dir.strip}/app/models/commands.rb"

# Create a new Command object
@command = Command.new

# Define the system man and its OS
@command.sysname = `uname -n`.strip
@command.os_type = `uname -s`.strip

# Now, we passed the command to run, so lets store it in .cmd
@command.cmd = ARGV[0]

# Now we execute the command and trap its output
@command.cmd_output =  `#{@command.cmd}`

# And now we save it to the database
@command.save!

# Now we artistically display a report of everything
puts "\t\t\t\t*************** [ TESTING REPORT FOR #{@command.sysname} ] ***************\t\t\t\t\n\n"
puts " COMMAND ID #: #{@command.id}\n SYSTEM TYPE: #{@command.os_type}\n EXECUTED COMMAND: #{@command.cmd}\n COMMAND OUTPUT: #{@command.cmd_output}"

# Now lets find all the previously stored runs
@commands = Command.find :all

# Next, we sort the commands on the ID field so it displays right
@commands.sort! { |old,cur| old.id <=> cur.id }

# Now, for each of those, display what they did, then delete them.
# TODO Optmize this with custom SQL in the future
@commands.each do |command|
  unless command.id == @command.id
    puts "SYSTEM: " + "#{command.sysname} - " + "Previous cmd ID: " + command.id.to_s + " - Executed: \"#{command.cmd.to_s}\"" + " at " +  "#{command.updated_at.to_s}"
    # Eventually, we'll separate this information and the actual delete. Leaving here while testing.
    #command.destroy
  end
end
