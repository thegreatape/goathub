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

  test "parsing news feed updates last_updated" do
    old_last_update = news_feeds(:yoda_feed)
    no_last_update = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/single_item.xml')
    updated = DateTime::parse('2011-04-07T17:14:58-07:00')

    no_last_update.create_news_items(xml)
    assert_equal updated, no_last_update.last_updated

    old_last_update.create_news_items(xml)
    assert_equal updated, old_last_update.last_updated
  end 

  test "creating news items from feed with multiple items" do
    feed = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/three_items.xml')
    assert_equal 0, feed.news_items(true).length
    feed.create_news_items(xml)

    assert_equal 3, feed.news_items(true).length
  end

  test "only create new news items with updated feeds" do
    first_update = IO.read('test/fixtures/feeds/first_update.xml')
    second_update = IO.read('test/fixtures/feeds/second_update.xml')
    feed = news_feeds(:empty_feed)

    feed.create_news_items(first_update)
    assert_equal 35, feed.news_items.count

    # one new item in update
    feed.create_news_items(second_update)
    assert_equal 36, feed.news_items(true).count
  end

  test "don't re-create existing news items with un-updated feeds" do
    feed = news_feeds(:empty_feed)
    xml = IO.read('test/fixtures/feeds/three_items.xml')

    feed.create_news_items(xml)
    assert_equal 3, feed.news_items(true).length
    assert_no_difference('feed.news_items(true).length') do
      feed.create_news_items(xml)
    end
  end

  test "retrieving unread news items" do
    # with pagination as well
  end


end
