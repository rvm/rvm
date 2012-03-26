#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rvm"
  s.version = `cat VERSION`
  s.authors = ["Wayne E. Seguin","Michal Papis"]
  s.email = ["wayneeseguin@gmail.com","mpapis@gmail.com"]
  s.homepage = "https://rvm.beginrescueend.com/"
  s.summary = "RVM is the Ruby enVironment Manager (rvm)"
  s.description = "RVM is the Ruby enVironment Manager (rvm). It manages Ruby application environments and switching between them."

  s.files = Dir.glob("lib/**/*") + %w(LICENCE README VERSION)
  s.require_path = 'lib'
  s.post_install_message = <<-TEXT
***********************************************************************************

This gem contains only the Ruby libraries for the RVM Ruby API.

In order to install RVM please use one of the methods listed in the documentation:

    https://rvm.beginrescueend.com/rvm/install/
    
such as,

    bash -s stable < <(curl -s \\
    https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

You can read more details about this process on the above mentioned install page
as well as the basics page:

    https://rvm.beginrescueend.com/rvm/basics/

Enjoy!

      ~Wayne

***********************************************************************************
TEXT
end
