class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.text :url
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
