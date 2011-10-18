class TestReport < ActiveRecord::Base
  has_many :commands
  
  attr_accessor :timings
  
  def record_timings(&cmds)
    self.timings = Benchmark.benchmark(CAPTION) do |x|
      x.report("Timings: ") { %x[#{cmds.call}] }
    end
  end
  
end
