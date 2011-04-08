require 'test_helper'

class NewsFeedTest < ActiveSupport::TestCase

  test "test creating news items from feed" do
    assert_difference('NewsItem.count') do 
      feed = news_feeds(:yoda_feed)
      xml = IO.read('test/fixtures/feeds/single_item.xml')
      feed.create_news_items(xml)
    end

    # this one plus the two fixtures
    assert_equal NewsItem.count, 3
  end

end
