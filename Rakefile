require "rubygems"

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

begin
  require "jeweler"
  require "lib/rvm/version"

  Jeweler::Tasks.new do |gemspec|
    # No longer packaging RVM with RVM API
    gemspec.name            = "rvm"
    gemspec.version         = RVM::Version::STRING
    gemspec.summary         = "Ruby Version Manager (rvm)"
    gemspec.require_paths   = ["lib"]
    gemspec.date            = Time.now.strftime("%Y-%m-%d")
    gemspec.description     = "Manages Ruby interpreter environments and switching between them."
    gemspec.platform        = Gem::Platform::RUBY
    gemspec.files           = ["README", "sha1", "LICENCE", "rvm.gemspec", Dir::glob("lib/**/**")].flatten
    # gemspec.executables     = Dir::glob("bin/rvm-*").map{ |script| File::basename script }
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

  This gem contains only the Ruby libraries for the RVM Ruby API.

  In order to install RVM please use one of the methods listed in the documentation

  http://rvm.beginrescueend.com/rvm/install/

  such as,

    bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-latest )

  followed by placing the sourcing line in your ~/.bash_profile or wherever may
  be appropriate for your setup (example, .zshenv, /etc/profile, ...):

    [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*

  After completing setup please open a new shell to use RVM and be sure to run
  'rvm notes' to gain a list of dependencies to install before installing the
  first Ruby. You can read more details about this process on the above
  mentioned install page as well as the basics page:

    http://rvm.beginrescueend.com/rvm/basics/

  Enjoy!

      ~Wayne

#{"*" * 80}
    POST_INSTALL_MESSAGE

  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

