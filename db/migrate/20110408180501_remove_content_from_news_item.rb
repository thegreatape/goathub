class RemoveContentFromNewsItem < ActiveRecord::Migration
  def self.up
      remove_column :news_items, :content
  end

  def self.down
      add_column :news_items, :content, :string
  end
end
