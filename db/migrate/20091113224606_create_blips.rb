class CreateBlips < ActiveRecord::Migration
  def self.up
    create_table :blips do |t|
      t.integer :story_id
      t.string :author
      t.string :avatar_path
      t.string :body
      t.integer :blip_id

      t.timestamps
    end
  end

  def self.down
    drop_table :blips
  end
end
