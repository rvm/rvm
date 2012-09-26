∴ rvm use [ruby-string]

Setup current shell to use a specific ruby version.


For a list of currently installed ruby string please run

  ∴ rvm list

To create a gemset if it does not already exist:

  ∴ rvm --create 1.9.2@funky

For creating a project .rvmrc file - From within the app's root_dir:

  ∴ rvm --rvmrc 1.9.2@funky

Above commands can be also combined to do it all in one pass:

  ∴ rvm --rvmrc --create use 1.9.2@funky
  Using /home/mpapis/.rvm/gems/ruby-1.9.2-p290 with gemset funky

Do not forget to check the generated .rvmrc file - it contains many useful
comments.  Note you must still 'rvm rvmrc trust' the newly created .rvmrc

If you attempt to use a ruby that is not installed and install-on-use is
not enabled, rvm will tell you the command necessary to install the
requested ruby.

  ∴ rvm use 1.9.3
  ruby-1.9.3 is not installed.
  To install do: 'rvm install ruby-1.9.3'

Also, an environment variable "rvm_recommended_ruby" will contain the
command. Using tab completion will expedite executing it.

  ∴ $rvm_recommended_ruby

Please see documentation for further information:

  https://rvm.io/rvm/basics

Also, you can combine the new flags --ruby-version and --version-conf

  ∴ rvm --create --ruby-version use 1.9.2@funky
  Using /home/mpapis/.rvm/gems/ruby-1.9.2-p290 with gemset funky

  ∴ rvm --create --versions-conf use 1.9.2@funky
  Using /home/mpapis/.rvm/gems/ruby-1.9.2-p290 with gemset funky

These files do not need to be trusted, however, if a .rvmrc file
exists, it will override the use of .ruby-version or .versions.conf!

Please see the documentation for further information:
  https://rvm.io/workflow/projects#ruby-versions

