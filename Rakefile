task :default => ["gem:refresh"]
namespace :gem do
  task :refresh do
    exec "gem uninstall rvm ; rm -f pkg/*.gem ./rvm.gemspec && rake gemspec && rake build && gem install pkg/*.gem --no-rdoc --no-ri"
  end

  desc "Build the rvm gem."
  task :build do
puts <<-LOCAL_INSTALL_WARNING

  \033[0;33mINSTALLING FROM SOURCE\033[0m

  If you're using rvm from source, don't build the gem
  Instead, run the following from the rvm source root

    \033[0;32mFor installing/updating:  ./install\033[0m

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
  Jeweler::Tasks.new do |gemspec|
    gemspec.name            = "rvm"
    gemspec.summary         = "Ruby Version Manager (rvm)"
    gemspec.require_paths   = ["lib"]
    gemspec.date            = Time.now.strftime("%Y-%m-%d")
    gemspec.description     = "Manages Ruby interpreter installations and switching between them."
    gemspec.platform        = Gem::Platform::RUBY
    gemspec.files           = ["install", "README", "LICENCE", "rvm.gemspec", "bash/*", "scripts/*", "examples/*", "config/*", Dir::glob("lib/**/**")].flatten
    gemspec.executables     = Dir::glob("bin/rvm-*").map{ |script| File::basename script }
    gemspec.require_path    = "lib"
    gemspec.has_rdoc        = File::exist?("doc")
    gemspec.rdoc_options    = ["--inline-source", "--charset=UTF-8"]
    gemspec.authors         = ["Wayne E. Seguin"]
    gemspec.email           = "wayneeseguin@gmail.com"
    gemspec.homepage        = "http://github.com/wayneeseguin/rvm"
    gemspec.extensions      << "extconf.rb" if File::exists?("extconf.rb")
    gemspec.rubyforge_project = "rvm"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "rake/testtask"
task :default => [:test_units]

desc "Run test suite."
Rake::TestTask.new("test") do |test|
  puts %x{./install}
  test.pattern = "test/*_test.rb"
  test.verbose = true
  test.warning = true
  test.libs << "test"
  test.test_files = FileList["test/test*.rb","test/**/*.rb"]
end

