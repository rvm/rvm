module RVM
  module InstanceMethods
    def rvm(command, options = {})
      result = RVM::Shell.new(command)
      [result.output, result.errors]
    end
  end

  def self.included(receiver)
    receiver.send(:include, InstanceMethods)
  end
end

include RVM
