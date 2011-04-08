class ChangeNewsItemDateToDatetime < ActiveRecord::Migration
  def self.up
    change_column :news_items, :date, :datetime
  end

  def self.down
    change_column :news_items, :date, :date
  end
end
