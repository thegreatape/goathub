require('rexml/document')
require('date')
require('net/https')
require('uri')

class NewsFeed < ActiveRecord::Base
  has_many :news_items
  belongs_to :user

  validates :feed_url, 
    :format => /https:\/\/github.com\/\w+\.private\.atom\?token=/,
    :presence => true

  def fetch
    uri = URI.parse(self.feed_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      self.last_polled = Time.now
      create_news_items(res.body)
      put self.errors if !self.save
    else
      # TODO logging
      puts "--- error updating feed #{self.feed_url}"
      puts res.body
    end
  end

  def create_news_items(feed)
    doc = REXML::Document.new(feed)

    entries = REXML::XPath.match(doc.root, '//feed/entry') 
    entries.each do |entry|
      date = DateTime.parse(entry.elements['updated'].text) 
      if !self.last_updated || date > self.last_updated
        item = NewsItem.new(:date => date)
        entry.each_recursive do |node|
          case node.name
          when 'link'
            item.link = node.attribute('href').value
          when 'author'
            node.each_element do |elem|
              item.author_name = elem.text if elem.name == 'name'
              item.author_link = elem.text if elem.name == 'uri'
            end
          when 'title'
            item.title = node.text
            # attempt to extract project name from title
            match = node.text.match(/(on|at) (\w+\/[\w-]+)/)
            if match
              item.project_name = match[2]
              item.project_link = "https://github.com/#{match[2]}"
            end
          when 'content'
            # <content> contains entity-escaped HTML  
            begin 
              content_doc = REXML::Document.new(node.text)
              REXML::XPath.match(content_doc.root, "//div[@class='message']").each do |message|
                item.message = message.children.to_s
              end
            rescue
              # fall back to just the node text if there's invalid xml
              item.message = node.text
            end
          when 'thumbnail'
            item.thumb_url = node.attribute('url').value
          end
        end
        item.news_feed_id = self.id
        item.save
      end
    end

    self.last_updated = DateTime.parse(doc.root.elements['updated'].text)
    self.save
  end

  def news_buckets(offset=0, limit=35)
    buckets = Hash.new {|hash, key| hash[key] = [] }
    self.news_items.order('date desc').limit(limit).offset(offset).each do |item|
      buckets[item.project_name || item.author_name] << item
    end
    return buckets.to_a.sort do |a,b|
      a_max = a[1].max_by {|i| i.date}.date
      b_max = b[1].max_by {|i| i.date}.date
      b_max <=> a_max
    end
  end

end
