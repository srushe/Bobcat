class Bookmark < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  
  validates_presence_of :url, :title
  validates_format_of :url, :with => URI::regexp(%w(http https)), :message => 'does not appear to be a web address', :allow_blank => true
  
  # Pagination info
  def self.per_page
    25
  end

end
