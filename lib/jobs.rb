require 'resque'

class UpdateFeed
  @queue = :news_feed_updates

  def self.perform(feed_id)
    NewsFeed.find(feed_id).fetch
  end
end


class UpdateAllFeeds
  @queue = :news_feed_updates

  def self.perform()
    NewsFeed.find_each do |feed|
      Resque.enqueue(UpdateFeed, feed.id)
    end
  end
end
