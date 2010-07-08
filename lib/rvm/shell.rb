module RVM
  # Provides Generic access to a more ruby-like shell interface.
  # For more details, see AbstractWrapper.
  module Shell

    autoload :AbstractWrapper,   'rvm/shell/abstract_wrapper'
    autoload :SingleShotWrapper, 'rvm/shell/single_shot_wrapper'
    # Current unimplemented
    #autoload :PersistingWrapper, 'rvm/shell/persisting_wrapper'
    autoload :TestWrapper,       'rvm/shell/test_wrapper'
    autoload :Utility,           'rvm/shell/utility'
    autoload :Result,            'rvm/shell/result'

    # Returns the default shell wrapper class to use
    def self.default_wrapper
      @@default_wrapper ||= SingleShotWrapper
    end

    # Sets the default shell wrapper class to use.
    def self.default_wrapper=(wrapper)
      @@default_wrapper = wrapper
    end

  end
end
