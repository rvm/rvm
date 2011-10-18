require 'benchmark'

include Benchmark

class Capture
  attr_accessor :data
end

@some_report = Capture.new

@some_report.data = Benchmark.benchmark(CAPTION) do |x|
  x.report("uname:") { %x[uname -a] }
end

print "In Report: " + @some_report.data.to_s


