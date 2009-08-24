module RVM
  VERSION = YAML.load_file("#{File.dirname(File.dirname(__FILE__))}/VERSION.yml")
end
