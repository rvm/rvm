class PygmentizeFilter < Nanoc3::Filter

  identifier :pygmentize

  def run(content, options = {})
    require "hpricot"
    document = Hpricot(content) 
    code_blocks = document.search("code").map do |code_block|
      code_block.inner_html = pygmentize(html_unescape(code_block.inner_html), code_block[:lang] || "ruby")
    end
    document.to_s
  end

  private

  def pygmentize(string, lang)
    html = ""
    pygmentize = %x{which pygmentize}.strip
    open("| #{pygmentize} -f html -l #{lang}", "w+") do |file|
      # Write the code to standard input of pygmentize.
      file.puts(string)
      # Close standard input so that we get some output.
      file.close_write
      # Read the output of pygmentize.
      html = file.read
    end
    html = "<pre><code>#{string.strip}</code></pre>" if html.empty?
    html.strip
  end

  def copy_text_to_file(string, identifier, dir)
    %x{echo '#{string.gsub("'",'\'')}' >> #{dir}/#{identifier}}
    "#{dir}/#{identifier}"
  end

  def html_unescape(escaped_text)
    escaped_text.gsub('&amp;', '&') .gsub('<', '<') .gsub('>', '>') .gsub('"', '"')
  end

end
