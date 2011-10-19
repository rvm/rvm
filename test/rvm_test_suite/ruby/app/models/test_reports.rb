class TestReport < ActiveRecord::Base
  has_many :commands
    
  def record_timings(&cmds)
    Benchmark.benchmark(CAPTION) do |x|
      x.report("Timings: ", &cmds)
    end
  end
  
end
