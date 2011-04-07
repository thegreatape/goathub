class NewsItem < ActiveRecord::Base
  validates :author_name, :date, :link, :content, :thumb_url, :presence => true
  validates :link, :project_link, :author_link, :format => /^https:\/\//
  after_initialize :set_defaults

  private
   def set_defaults
     self.read = false
   end
end
