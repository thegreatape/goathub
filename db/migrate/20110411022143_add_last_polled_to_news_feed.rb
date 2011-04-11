class AddLastPolledToNewsFeed < ActiveRecord::Migration
  def self.up
    add_column :news_feeds, :last_polled, :datetime
  end

  def self.down
    remove_column :news_feeds, :last_polled
  end
end
