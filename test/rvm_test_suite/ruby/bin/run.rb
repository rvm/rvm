# Load requirements
#
# RubyGems
require 'rubygems'

# Commandline options parser
require 'clint'

# ActiveRecord since models are AR backed
require 'active_record'
require 'active_support'

# Benchmarking for TestReports
require 'benchmark'
include Benchmark


# Now, connect to the database using ActiveRecord
ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + "/../config/database.yml"))


# Now load the Model(s).
Dir[File.dirname(__FILE__) + "/../app/models/*.rb"].each do |filename|
  # "#{filename}" == filename.to_s == filename - so just call filename
  load filename
end


# Now create both a Command and a Report object
@command = Command.new
@test_report = TestReport.new


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
    
    # Capture the system's name and its OS
    @command.sysname = %x[uname -n].strip
    @command.os_type = %x[uname -s].strip

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
          # Generate the timings. This is done by passing in the block to be executed which includes storing the
          # output in @commands.cmd_output, then recording the returned timings generated within the record_timings call
          # into @test-report.timings. and save the report.
          @test_report.timings = @test_report.record_timings { @command.cmd_output = %x[#{@command.cmd} 2>&1] }
          @test_report.save!

          # now that @test_report has been saved and an ID generated, associate that test report with @command
          @command.test_reports << @test_report
          # Now save @command to generate its own ID, and then associate that with @test_report and save the association
          # to @test_report
          @command.save!
          @test_report.commands << @command
          @test_report.save!          
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
  # Now we execute the command and trap its output, but don't display it on the screen.
  # We'll show it later on, in the report.
  @command.cmd_output =  %x[#{@command.cmd} 2>&1]

  # Capture the system's name and its OS
  @command.sysname = %x[uname -n].strip
  @command.os_type = %x[uname -s].strip

  # TODO - Add test timings here as well for the singular command capability as well.
  
  # And now we save it all to the database.
  @command.save!

end


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