#!/usr/bin/env ruby
require "rubygems"

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
    local_dir  = File.expand_path("..", __FILE__)
    remote_dir = "$(pwd)/rvm"
    remote_script = "vboxtest/test_suite.sh"
    sh "'#{File.expand_path("../vboxtest.sh", __FILE__)}' -L '#{local_dir}' -R '#{remote_dir}' -S '#{remote_script}' #{hosts.join(' ')}"
  end

  desc 'Run the tests locally'
  task :local_test do
    sh File.expand_path("../vboxtest/test_suite.sh", __FILE__)
  end
end
