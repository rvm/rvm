require "digest"

raise "Usage: #{$0} VERSION" unless ARGV.size == 1

version = ARGV[0]

def replace_line(file, pattern, replacement)
  lines = File.readlines(file)
  i = lines.index { |line| pattern =~ line }
  lines[i] = replacement
  File.write(file, lines.join)
end

def insert_after(file, pattern, new_lines)
  lines = File.readlines(file)
  i = lines.rindex { |line| pattern =~ line }
  lines.insert(i+1, *new_lines)
  File.write(file, lines.join)
end

replace_line "config/db", /truffleruby_version=/, "truffleruby_version=#{version}\n"
replace_line "config/known", /truffleruby\[/, "truffleruby[-#{version}]\n"

insert_after "config/known_strings", /^truffleruby/, ["truffleruby-#{version}\n"]

%w[md5 sha512].each { |algorithm|
  digests = %w[linux-amd64 macos-amd64].map { |platform|
    basename = "truffleruby-#{version}-#{platform}.tar.gz"
    archive = File.expand_path("../ruby-versions/pkg/#{basename}")
    digest = Digest(algorithm.upcase).file(archive).hexdigest
    "#{basename}=#{digest}\n"
  }
  insert_after "config/#{algorithm}", /^truffleruby/, digests
}
