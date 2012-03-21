# Recipes for using RVM on a server with capistrano.

unless Capistrano::Configuration.respond_to?(:instance)
  abort "rvm/capistrano requires Capistrano >= 2."
end

Capistrano::Configuration.instance(true).load do

  # Taken from the capistrano code.
  def _cset(name, *args, &block)
    unless exists?(name)
      set(name, *args, &block)
    end
  end

  set :default_shell do
    shell = File.join(rvm_bin_path, "rvm-shell")
    ruby = rvm_ruby_string.to_s.strip
    if "#{ruby}" == "release_path"
      shell = "rvm_path=#{rvm_path} #{shell} --path '#{release_path}'"
    else
      shell = "rvm_path=#{rvm_path} #{shell} '#{ruby}'" unless ruby.empty?
    end
    shell
  end

  # Let users set the type of their rvm install.
  _cset(:rvm_type, :system)

  # Define rvm_path
  # This is used in the default_shell command to pass the required variable to rvm-shell, allowing
  # rvm to boostrap using the proper path.  This is being lost in Capistrano due to the lack of a
  # full environment.
  _cset(:rvm_path) do
    case rvm_type
    when :root, :system
      "/usr/local/rvm"
    when :local, :user, :default
      "$HOME/.rvm/"
    else
      rvm_type.to_s.empty? ?  "$HOME/.rvm" : rvm_type.to_s
    end
  end

  # Let users override the rvm_bin_path
  _cset(:rvm_bin_path) do
    case rvm_type
    when :root, :system
      "/usr/local/rvm/bin"
    when :local, :user, :default
      "$HOME/.rvm/bin"
    else
      rvm_type.to_s.empty? ?  "#{rvm_path}/bin" : rvm_type.to_s
    end
  end

  # Use the default ruby on the server, by default :)
  _cset(:rvm_ruby_string, "default")

  # Let users set the install type and shell of their choice.
  _cset(:rvm_install_type, :stable)
  _cset(:rvm_install_shell, :bash)

  # Let users set the (re)install for ruby.
  _cset(:rvm_install_ruby, :install)

  namespace :rvm do
    desc <<-EOF
      Install RVM of the given choice to the server.
      By default RVM "stable" is installed, change with:

      set :rvm_install_type, :head

      By default BASH is used for installer, change with:

      set :rvm_install_shell, :zsh
    EOF
    task :install_rvm do
      run "#{rvm_install_shell} -s #{rvm_install_type} \
< <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)", :shell => "#{rvm_install_shell}"
    end

    desc <<-EOF
      Install RVM ruby to the server, create gemset if needed.
      By default ruby is installed, you can reinstall with:

      set :rvm_install_ruby, :reinstall

      By default BASH is used for installer, change with:

      set :rvm_install_shell, :zsh
    EOF
    task :install_ruby do
      ruby, gemset = rvm_ruby_string.to_s.strip.split /@/
      if %w( release_path default ).include? "#{ruby}"
        raise "ruby can not be installed when using :rvm_ruby_string => :#{ruby}"
      else
        run "#{File.join(rvm_bin_path, "rvm")} #{rvm_install_ruby} #{ruby}", :shell => "#{rvm_install_shell}"
        if gemset
          run "#{File.join(rvm_bin_path, "rvm")} #{ruby} do rvm gemset create #{gemset}", :shell => "#{rvm_install_shell}"
        end
      end
    end
  end
end

# E.g, to use ree and rails 3:
#
#   require 'rvm/capistrano'
#   set :rvm_ruby_string, "ree@rails3"
#
