This directory will contain testing features I write in cucumber/gherkin.
NOTE: These tests are PURPOSEFULLY not working. They aren't linked to aruba
or any other testing suite on purpose. These are merely for me to textually
formulate using cucumber/gherkin as the formation of the suite.
Eventually, I DO plan on linking in several gems such as aruba. With aruba
I will need to extend its current capabilities. The *sole* purpose of this
directory is to contain feature files formalizing specific behaviour patterns
of RVM.

I'm doing this, once again, only to textually and mentally lay out and formalize
each segment of RVM's behaviours at this time. Since these are specifically for
RVM, and RVM only, I felt making this directory for storage of the *.feature files
was a good idea. This is just for storage of my renditions only!

DO NOT EXPECT THESE TO WORK!

UPDATE: Currently, I've reworked everything in Ruby. The ruby sub-directory here
contains what I think should be a good way to track systems, commands, returned
test data, and generate reports. The basic idea is to use the test nodes' system
ruby to execute the test scripts intially, and then use rvm itself for consecutive
test runs. The data trapped is the system name, the command executed, and the
output of that command. The tables also have a .id field as well like one would
expect in a Rails application though we're not using rails here.

Right now the current rendition does not display the command output as its command
is executed, it merely traps it in the variable and stores it in the database.
The command output you do see comes from the report itself. The 'report' needs to
be moved to its own action within the Command model or a Report model created.
I personally prefer the creation of a Report'ing model.

I'm also thinking I'd like to set it up so that you scp a .gz to the test nodes,
and script it so that a cronjob is injected onto each node for scheduling.
Then once the tests are complete and the data recorded, delete the directories
and script(s) from the nodes. I'd like to use the .id field for directory name.

UPDATE: Right now, commands can be executed eitehr as a single command, or in a batch. 
All commands whether single or batch are individually trapped for output and timing of
the command(s) to a database server on the network. No testing node hasI also can generate
Test Reports with linked commands where each command that was executed for that rest run
are linked to the specific test report (@commands = @test_report.commands.all). I also trap
the phsyical node name, its OS type, and the like. This should make it so that we can do
something like "Give me all Darwin related test runs that executed 'rvm install 1.9.2' and
give me aggregate time of how long it took for that command to complete." and "Give me all
Ubuntu-specific Test Reports for the last month." The hardest part of all that will be log
collection of failed commands such as the config.log, make.log etc and storage in the db
linked to both the Test Report itself, as well as each command both specific to the machine
and to the OS involved, as well as the Ruby it failed against. Thats on the TOD list.
This should allow us to inspect any aspect of command executions collectively and singularly.
Also, the goal will be to provide a web frontend to the testing cluster through a Rails app.
This will be able to be installed anywhere, EXCEPT for the nodes themselves, like the dbs.

I plan on adding SSH support to send commands out to the test nodes, and both git and cron
support as well. The reason for the git support is I have a half formed idea of recording
testing data in a git repository such as it was passed to the testing nodes. This will allow
someone to pull that specific commit (by the git SHA-1 hash number), and be able to execute
the *exact* same data against their own machine in order to facilitate A) validation of the
data, and B) retesting using a known base + their own inegrated modifications.
I'm adding cron support in order to be able to schedule testruns as needed.

--
Deryl R. Doucette

Self PS: Need to find any additional gems for testing shell scripts in addition
to aruba.

