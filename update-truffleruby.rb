require "digest"

raise "Usage: #{$0} VERSION RELEASE_DIRECTORY" unless ARGV.size == 2

version, release_directory = ARGV

def replace_line(file, pattern, replacement)
  lines = File.readlines(file)
  i = lines.index { |line| line.start_with?(pattern) }
  lines[i] = lines[i][pattern] + replacement
  File.write(file, lines.join)
end

def insert_after(file, pattern, new_lines)
  lines = File.readlines(file)
  i = lines.rindex { |line| pattern =~ line }
  lines.insert(i+1, *new_lines)
  File.write(file, lines.join)
end

replace_line "config/db", /truffleruby_version=/, "#{version}\n"
replace_line "config/known", /truffleruby\[/, "-#{version}]\n"

insert_after "config/known_strings", /^truffleruby/, ["truffleruby-#{version}\n"]

%w[md5 sha512].each { |algorithm|
  digests = %w[linux-amd64 linux-aarch64 macos-amd64 macos-aarch64].map { |platform|
    basename = "truffleruby-#{version}-#{platform}.tar.gz"
    archive = "#{release_directory}/#{basename}"
    digest = Digest(algorithm.upcase).file(archive).hexdigest
    "#{basename}=#{digest}\n"
  }
  insert_after "config/#{algorithm}", /^truffleruby/, digests
}

replace_line "CHANGELOG.md", /\* Add support for TruffleRuby (.+)/, ", #{version}\n"
