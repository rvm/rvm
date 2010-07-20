require 'yaml'

module RVM
  class Environment

    def info(*ruby_strings)
      ruby_string = normalize_ruby_string(ruby_strings)
      res = rvm(:info, ruby_string)
      res.successful? ? YAML.load(res.stdout) : {}
    end

  end
end
