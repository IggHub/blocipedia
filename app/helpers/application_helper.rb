module ApplicationHelper
  def markdown(stuff)
   renderer = Redcarpet::Render::HTML.new
   extensions = {fenced_code_blocks: true, quote: true, autolink: true, underline: true}
   redcarpet = Redcarpet::Markdown.new(renderer, extensions= {})
   (redcarpet.render stuff).html_safe
 end
end
