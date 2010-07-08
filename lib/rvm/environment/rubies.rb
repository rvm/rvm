module RVM
  class Environment

    # Installs the given ruby
    def install(rubies, opts = {})
      rvm(:install, normalize_ruby_string(rubies), opts).successful?
    end

    # Uninstalls a ruby (remove but keeps src etc)
    def uninstall(rubies, opts = {})
      rvm(:uninstall, normalize_ruby_string(rubies), opts).successful?
    end

    # Removes a given ruby from being managed by rvm.
    def remove(rubies, opts = {})
      rvm(:remove, normalize_ruby_string(rubies), opts).successful?
    end

    # Changes the ruby string for the current environment.
    def use(ruby_string, opts = {})
      ruby_string = ruby_string.to_s
      if rvm(:use, ruby_string).successful?
        @environment_name = ruby_string
        @expanded_name    = nil
      end
    end

    protected

    def normalize_ruby_string(rubies)
      Array(rubies).join(",")
    end

  end
end
