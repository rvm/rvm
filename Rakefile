
task :default => ["test"]
task :test do exec "bash -l -c \"./test/suite\"" ; end

namespace :gem do
  task :refresh do
    exec "gem uninstall rvm ; rm -f pkg/*.gem ./rvm.gemspec && rake gemspec && rake build && gem install pkg/*.gem --no-rdoc --no-ri"
  end

  desc "Build the rvm gem."
  task :build do
puts <<-LOCAL_INSTALL_WARNING

  $(tput setaf 3)INSTALLING FROM SOURCE$(tput sgr0)

  If you are using rvm from source, DO NOT build the gem.
  Instead, run the following from the rvm source's root dir.

    $(tput setaf 2)For installing/updating:  ./install$(tput sgr0)

LOCAL_INSTALL_WARNING
    puts "$(gem build rvm.gemspec)"
  end

  desc "Install the rvm gem (NO sudo)."
  task :install do
    %x{gem install rvm*.gem --no-rdoc --no-ri -l}
  end
end

require "rubygems"
begin
  require "jeweler"
  require "lib/rvm/version"

  Jeweler::Tasks.new do |gemspec|
    gemspec.name            = "rvm"
    gemspec.version         = RVM::Version::STRING
    gemspec.summary         = "Ruby Version Manager (rvm)"
    gemspec.require_paths   = ["lib"]
    gemspec.date            = Time.now.strftime("%Y-%m-%d")
    gemspec.description     = "Manages Ruby interpreter environments and switching between them."
    gemspec.platform        = Gem::Platform::RUBY
    gemspec.files           = ["install", "README", "sha1", "LICENCE", "rvm.gemspec", "bash/*", "binscripts/*", "scripts/*", "examples/*", "config/*", "help/**", Dir::glob("lib/**/**")].flatten
    gemspec.executables     = Dir::glob("bin/rvm-*").map{ |script| File::basename script }
    gemspec.require_path    = "lib"
    gemspec.has_rdoc        = File::exist?("doc")
    gemspec.rdoc_options    = ["--inline-source", "--charset=UTF-8"]
    gemspec.authors         = ["Wayne E. Seguin"]
    gemspec.email           = "wayneeseguin@gmail.com"
    gemspec.homepage        = "http://github.com/wayneeseguin/rvm"
    gemspec.extensions      << "extconf.rb" if File::exists?("extconf.rb")
    gemspec.rubyforge_project = "rvm"
    gemspec.post_install_message = <<-POST_INSTALL_MESSAGE
#{"*" * 80}

  In order to setup rvm for your user's environment you must now run rvm-install.
  rvm-install will be found in your current gems bin directory corresponding to where the gem was installed.

  rvm-install will install the scripts to your user account and append itself to your profiles in order to
  inject the proper rvm functions into your shell so that you can manage multiple rubies.

#{"*" * 80}
    POST_INSTALL_MESSAGE

  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

