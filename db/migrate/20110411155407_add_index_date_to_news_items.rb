class AddIndexDateToNewsItems < ActiveRecord::Migration
  def self.up
    add_index :news_items, [:date, :news_feed_id]
  end

  def self.down
    remove_index :news_items, [:date, :news_feed_id]
  end
end
