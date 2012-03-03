module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title(title='')
    content_for(:header_title) { 'Bobcat' + (" - " + title.to_s if title) }
    content_for(:page_title)   { title || '' }
  end

end
