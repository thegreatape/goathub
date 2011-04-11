class UpdateNewsFeeds
  @queue = :news_feed_updates

  def self.perform(feed_id)
    NewsFeed.find(feed_id).fetch
  end
end
