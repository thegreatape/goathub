class NewsItem < ActiveRecord::Base
  belongs_to :news_feed

  validates :author_name, :date, :link, :message, :thumb_url, :presence => true
  validates :link, :author_link, :format => /^https:\/\//
  validates :project_link, :format => /^https:\/\//, :allow_nil => true
  after_initialize :set_defaults

  private
   def set_defaults
     self.read = false
   end
end
