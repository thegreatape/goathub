require 'test_helper'
require 'date'

class NewsFeedTest < ActiveSupport::TestCase

  test "creating news items from feed" do
    feed = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/single_item.xml')
    assert_difference('NewsItem.count') do 
      feed.create_news_items(xml)
    end

    assert_equal 1, feed.news_items.length

    item = feed.news_items[0]
    assert_equal "eagereyes", item.author_name 
    assert_equal "https://github.com/eagereyes", item.author_link
    assert_equal "polotek/libxmljs", item.project_name
    assert_equal "https://github.com/polotek/libxmljs", item.project_link
    assert_equal "https://github.com/polotek/libxmljs/issues/44", item.link
    assert_equal DateTime::parse('2011-04-07T17:14:58-07:00'), item.date
    assert_equal "https://secure.gravatar.com/avatar/50b46e7a1eeb1d4e8106b33f064a2c13?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png", item.thumb_url 
    assert_equal 'eagereyes closed issue 44 on polotek/libxmljs', item.title
    assert_match /\s*<blockquote>\s*Segfault when using XML Builder\s*<\/blockquote>\s*/, item.message
  end

  test "creating news items from feed with multiple items" do
    feed = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/three_items.xml')
    assert_equal 0, feed.news_items(true).length
    feed.create_news_items(xml)

    assert_equal 3, feed.news_items(true).length
  end

  #
  # le stub tests
  #
  test "don't re-create existing news items" do
  end

  test "retrieving unread news items" do
    # with pagination as well
  end


end
