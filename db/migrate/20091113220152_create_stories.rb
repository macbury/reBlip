class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.text :body
      t.string :author
      t.string :avatar_path
      t.integer :blip_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
