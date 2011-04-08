class AddTitleAndMessageToNewsItem < ActiveRecord::Migration
  def self.up
    add_column :news_items, :title, :string
    add_column :news_items, :message, :string
  end

  def self.down
    remove_column :news_items, :title, :string
    remove_column :news_items, :message, :string
  end
end
