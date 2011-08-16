require "rubygems"
require "hoe"

Hoe.spec "rvm" do

  developer "Wayne E. Seguin", "wayneeseguin@gmail.com"

  # TODO: package the release with the API .gem
  #gemspec.files           = [
  #  "README", "sha1", "LICENCE", "rvm.gemspec",
  #  # TODO: Go through manifest carefully.
  #  # FOR NOW glob
  #  Dir::glob("lib/**/**"),
  #  Dir::glob("releases/rvm-#{RVM::Version::STRING}.tar.gz*")
  #].flatten

  spec_extras[:rdoc_options] = proc do |ary|
    # hoe kinda sucks for this! TODO: submit patch for Hoe#rdoc_options
    ary.push "--inline-source", "--charset=UTF-8"
  end

  spec_extras[:post_install_message] = <<-POST_INSTALL_MESSAGE
#{"*" * 80}

  This gem contains only the Ruby libraries for the RVM Ruby API.

  In order to install RVM please use one of the methods listed in the
  documentation:

    https://rvm.beginrescueend.com/rvm/install/

  such as,

    bash < <(curl -s -B https://rvm.beginrescueend.com/install/rvm)

  followed by placing the sourcing line in your ~/.bash_profile or wherever may
  be appropriate for your setup (example, .zshenv, /etc/profile, ...):

    # Load RVM into a shell session *as a function*
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

  After completing setup please open a new shell to use RVM and be sure to run
  'rvm notes' to gain a list of dependencies to install before installing the
  first Ruby. You can read more details about this process on the above
  mentioned install page as well as the basics page:

    https://rvm.beginrescueend.com/rvm/basics/

  Enjoy!

      ~Wayne

#{"*" * 80}
    POST_INSTALL_MESSAGE
end

task :test do
  exec "bash -l -c \"./test/suite\""
end

#
# VirtualBox Helpers
#

# Matches a host declaration in a ssh config file.
HOST_REGEXP     = /^\s*Host\s+([^\s#*]+)/
SNAPSHOT        = (ENV['SNAPSHOT'] || 'CURRENT').upcase
SSH_CONFIG_FILE = ENV['SSH_CONFIG_FILE'] || File.expand_path('../config/ssh', __FILE__)

def shell(cmd)
  puts "$ #{cmd}"
  system(cmd)
end

def hosts
  @hosts ||= begin
    hosts = []

    File.open(SSH_CONFIG_FILE) do |io|
      io.each_line do |line|
        next unless line =~ HOST_REGEXP
        hosts << $1
      end
    end

    hosts
  end
end

namespace :vbox do
  desc "start each vm"
  task :start => :stop do
    hosts.each do |host|
      shell "VBoxManage -q snapshot #{host} restore #{SNAPSHOT}"
      shell "VBoxManage -q startvm #{host} --type headless"
      shell "ssh -MNf -F '#{SSH_CONFIG_FILE}' '#{host}' >/dev/null 2>&1 </dev/null"
    end
  end

  desc "stop each vm"
  task :stop do
    hosts.each do |host|
      if `VBoxManage -q list runningvms`.include?(host)
        shell "VBoxManage -q controlvm #{host} poweroff"
      end
    end
  end
  
  desc 'Run the tests remotely on each VM'
  task :test do
    begin
      Rake::Task["vbox:start"].invoke
      Rake::Task["vbox:remote_test"].invoke
    ensure
      Rake::Task["vbox:stop"].execute(nil)
    end
  end

  desc 'Run the tests remotely (assuming each VM is running)'
  task :remote_test do
    local_dir = File.expand_path("../vboxtest", __FILE__)
    sh "'#{File.expand_path("../vboxtest.sh", __FILE__)}' -L '#{local_dir}' #{hosts.join(' ')}"
  end

  desc 'Run the tests locally'
  task :local_test do
    sh File.expand_path("../vboxtest/test_suite.sh", __FILE__)
  end
end
