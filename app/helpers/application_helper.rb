# frozen_string_literal: true

# application helper
module ApplicationHelper
  def markdown(text)
    options = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end
end
