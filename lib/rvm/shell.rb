module RVM
  class Shell
    attr_reader :errors, :output

    def initialize(command)
      @command = (command =~ /^rvm /) ? command : "rvm #{command}"
      Open4::popen4("/bin/bash -l -c '#{@command.tr("'","\\'")}'") do |pid, stdin, stdout, stderr|
        stdin.close
        @output = stdout.readlines.join
        @errors = stderr.readlines.join
      end
    end
  end
end
