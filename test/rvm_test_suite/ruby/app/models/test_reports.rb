class TestReport < ActiveRecord::Base
  has_many :commands
  
  attr_accessor :timings
  
  def record_timings(&cmds)
    p cmds.inspect
    self.timings = Benchmark.benchmark(CAPTION) do |x|
      x.report("Timings: ", &cmds)
    end
  end
  
end
