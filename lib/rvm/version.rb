module RVM
  module Version

    require "yaml"

    YAML   = YAML.load_file("#{File.expand_path(File.dirname(__FILE__))}/../VERSION.yml")

    MAJOR  = YAML[:major]
    MINOR  = YAML[:minor]
    PATCH  = YAML[:patch]

    STRING = "#{MAJOR}.#{MINOR}.#{PATCH}"

  end
end
