class Command < ActiveRecord::Base
  belongs_to :test_report

  before_create do |command|
    # Capture the system's name and its OS
    command.sysname = %x[uname -n].strip
    command.os_type = %x[uname -s].strip
  end

  def run( cmd )
    self.cmd = cmd
    
    Benchmark.benchmark(CAPTION) do |x|
      self.timings = x.report("Timings: ") do
        self.cmd_output = %x[ #{self.cmd} 2>&1 ]
      end
    end
  end
end
