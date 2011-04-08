require('rexml/document')
require('date')

class NewsFeed < ActiveRecord::Base
  has_many :news_items
  belongs_to :user

  validates :feed_url, 
    :format => /https:\/\/github.com\/\w+\.private\.atom\?token=/,
    :presence => true

  def update
  end

  def create_news_items(feed)
    doc = REXML::Document.new(feed)
    entries = REXML::XPath.match(doc.root, '//feed/entry') 
    entries.each do |entry|
      item = NewsItem.new
      entry.each_recursive do |node|
        case node.name
        when 'link'
          item.link = node.attribute('href')
        when 'author'
          node.each_element do |elem|
            item.author_name = elem.text if elem.name == 'name'
            item.author_link = elem.text if elem.name == 'uri'
          end
        # TODO create title field and extract text from
        # url-escaped markup in text field
        when 'content'
          item.content = node.text
        when 'thumbnail'
          item.thumb_url = node.attribute('url')
        when 'updated'
          item.date = DateTime.parse(node.text)
        end
      end
      item.news_feed_id = self.id
      item.save
      #if !item.save
        #puts "--- didn't save! ---"
        #puts item.errors.full_messages
      #else 
        #puts "SAVED"
      #end

    end
  end

end
