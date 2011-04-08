require 'test_helper'

class NewsFeedTest < ActiveSupport::TestCase

  test "test creating news items from feed" do
    feed = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/single_item.xml')
    assert_difference('NewsItem.count') do 
      feed.create_news_items(xml)
    end

    assert_equal 1, feed.news_items.length

  end

end
