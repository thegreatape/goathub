class AddNewsFeedIdToNewsItem < ActiveRecord::Migration
  def self.up
    add_column :news_items, :news_feed_id, :integer
  end

  def self.down
    remove_column :news_items, :news_feed_id
  end
end
