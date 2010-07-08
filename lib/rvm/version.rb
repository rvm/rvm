require 'yaml'

module RVM
  module Version

    # YAML of raw version info
    VERSION_YAML = YAML.load_file(File.expand_path("../VERSION.yml", File.dirname(__FILE__)))

    # Current major version of rvm
    MAJOR  = VERSION_YAML[:major]
    # Current minor version of rvm
    MINOR  = VERSION_YAML[:minor]
    # Current patch level of rvm
    PATCH  = VERSION_YAML[:patch]
    # A String with the current rvm version
    STRING = [MAJOR, MINOR, PATCH].join(".").freeze

  end
end
