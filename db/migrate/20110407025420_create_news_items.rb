class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.string :author_name
      t.string :project_name
      t.string :project_link
      t.string :author_link
      t.date :date
      t.string :thumb_url
      t.string :link
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end

  def self.down
    drop_table :news_items
  end
end
