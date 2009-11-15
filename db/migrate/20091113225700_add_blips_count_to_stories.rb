class AddBlipsCountToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :blips_count, :integer, :default => 0
  end

  def self.down
    remove_column :stories, :blips_count
  end
end
