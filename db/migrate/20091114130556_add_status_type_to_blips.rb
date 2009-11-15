class AddStatusTypeToBlips < ActiveRecord::Migration
  def self.up
    add_column :blips, :status_type, :string, :default => 'Status'
    add_column :blips, :asset_path, :string
    add_column :stories, :status_type, :string, :default => 'Status'
    add_column :stories, :asset_path, :string
  end

  def self.down
    remove_column :blips, :asset_path
    remove_column :blips, :status_type
    remove_column :stories, :asset_path
    remove_column :stories, :status_type
  end
end
