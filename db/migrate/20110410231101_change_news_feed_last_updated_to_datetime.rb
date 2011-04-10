class ChangeNewsFeedLastUpdatedToDatetime < ActiveRecord::Migration
  def self.up
    change_column :news_feeds, :last_updated, :datetime
  end

  def self.down
    change_column :news_feeds, :last_updated, :date
  end
end

