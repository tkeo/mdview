require 'mdview/version'
require 'redcarpet'

module Mdview
  class << self
    def run
      text = ARGF.readlines.join
      md = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      html = wrap_html(md.render(text))
      filename = write_temporary_file(html)
      system("open #{filename}")
    end

    def wrap_html(content)
      html = <<EOS
<html>
<head><meta charset="UTF-8"></head>
<body>
#{content}
</body>
</html>
EOS
    end

    def write_temporary_file(html)
      filename = File.join('/tmp', "md#{Time.now.strftime('%Y%m%d%H%M%S')}.html")
      File.open(filename, 'w+') do |f|
        f.write(html)
      end
      filename
    end
  end
end
