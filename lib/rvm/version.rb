module RVM
  require "yaml"
  VERSION = YAML.load_file("#{File.expand_path(File.dirname(__FILE__))}/../VERSION.yml")
end
