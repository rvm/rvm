module RVM
  class Environment

    # Returns the contents of the env file.
    def env_contents
      rvm(:env).stdout
    end

    # Returns the path to the env file
    def env_path
      rvm(:env, :path => true).stdout.strip
    end

    # Returns a ruby-like wrapper for the env functions
    def env
      @env_wrapper ||= EnvWrapper.new(self)
    end

    # Returns the path for the given command
    def path_for(command)
      run(:command, "-v", command).stdout.strip
    end
    alias which path_for

    # Gets the identifier loaded when changing to a given path.
    # ideally this would be used to extract a projects ruby version.
    def environment_identifier_for_path(path)
      full_path = File.expand_path(path)
      command = "{ cd #{escape_argument full_path}; } >/dev/null 2>&1"
      command << "; __rvm_environment_identifier"
      run(command).stdout.strip
    end

    # Simple ruby like wrapper for envs.
    class EnvWrapper

      def initialize(parent)
        @parent = parent
      end

      # Contents of the env file.
      def contents
        @parent.env_contents
      end
      alias read contents
      alias to_s contents

      # The path of the env file.
      def path
        @parent.env_path
      end

      # Opens a file on the env file.
      def to_file
        File.open(path)
      end

    end

  end
end
