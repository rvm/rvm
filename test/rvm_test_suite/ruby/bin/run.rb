# Load requirements
require 'clint'

# Connect to the database using ActiveRecord
load File.join(File.dirname(__FILE__), "bin/connect.rb")

# Now load the Model(s)
Dir[File.dirname(__FILE__) + "/app/models/*.rb"].each do |filename|
  # "#{filename}" == filename.to_s == filename - so just call filename
  load filename
end

# Now create both a Command and a Reportobject.
@command = Command.new
@report = Report.new


# Create a commandline parser object
cmdline = Clint.new

# Define the general usage message
cmdline.usage do
  $stderr.puts "Usage: #{File.basename(__FILE__)} [-h|--help]  ['rvm command_to_run'] [-s|--script rvm_test_script]"
end

# Define the help message
cmdline.help do
  $stderr.puts "  -h, --help\tshow this help message"
  $stderr.puts "Note: RVM commandsets not in a scriptfile must be surrounded by '' - e.g. #{File.basename(__FILE__)} 'rvm info'"
end

# Define the potential options
cmdline.options :help => false, :h => :help
cmdline.options :script => false, :s => :script

# Parse the actual commandline arguments
cmdline.parse ARGV

# If the command options is for help, usage, or there are no arguments
# then display the help message and abort.
if cmdline.options[:help] || ARGV[0] == nil
  cmdline.help
  abort
elsif cmdline.options[:script]
    # Open the script and parse. Should something go wrong with the file handler
    # display the help and abort. Wrap in a begin/rescue to handle it gracefully.
    # This executes each line storing that command's returned data in the database.
      begin
        # We call ARGV[0] here rather than ARGV[1] because the original ARGV[0] was
        # --script (or -s). when cmdline.options[:script] gets processed, it gets
        # dumped and the remaining argument(s) are shifted down in the ARGV array.
        # So now the script name is ARGV[0] rather than the normal ARGV[1]
        # We'll have to do this over and over as we keep processing deeper in the
        # options parsing if there were more options allowed / left.
        File.foreach(ARGV[0]) do |cmd|
          # Strip off the ending '\n'
          cmd.strip!
          # Skip any comment lines
          next if cmd =~ /^#/ or cmd.empty?
          @command.cmd = cmd
          @command.cmd_output = %x[#{@command.cmd} 2>&1]
          @command.save!
        end
      rescue Errno::ENOENT => e
        # The file wasn't found so display the help and abort.
        cmdline.help
        abort
      end
else
  # All is good so onwards and upwards! This handles when just a single command,
  # not a script, is passed
  @command = Command.new("cmd" => ARGV[0])
end


# Capture the system's name and its OS
@command.sysname = %x[uname -n].strip
@command.os_type = %x[uname -s].strip


# Now we execute the command and trap its output, but don't display it on the screen.
# We'll show it later on, in the report.
@command.cmd_output =  %x[#{@command.cmd} 2>&1]

# And now we save it all to the database.
@command.save!

# Now we artistically display a report of everything
puts "\t\t\t\t*************** [ TESTING REPORT FOR #{@command.sysname} ] ***************\t\t\t\t\n\n"
puts " COMMAND ID #: #{@command.id}\n SYSTEM TYPE: #{@command.os_type}\n EXECUTED COMMAND: #{@command.cmd}\n COMMAND OUTPUT: #{@command.cmd_output}"

# Now lets find all the previously stored runs.
@commands = Command.find :all

# Next, we sort the commands on the ID field so it displays right.
@commands.sort! { |old,cur| old.id <=> cur.id }

# Now, for each of the previously executed commands on this particular system, display them.
# Only display the commands for this particular machine, but not the currently executed command,
# since we'll also be storing data from the other machines in the cluster as well.
# TODO Optmize this with custom SQL in the future.
@commands.each do |command|
  unless command.id == @command.id 
    if command.sysname != @command.sysname
      break
    end
    puts "SYSTEM: " + "#{command.sysname} - " + "Previous cmd ID: " + command.id.to_s + " - Executed: \"#{command.cmd.to_s}\"" + " at " +  "#{command.updated_at.to_s}"
  end
end

# Explicitly return 0 for success if we've made it here.
exit 0