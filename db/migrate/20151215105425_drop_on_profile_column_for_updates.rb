class DropOnProfileColumnForUpdates < ActiveRecord::Migration
  def change
    remove_column :updates, :on_profile, :boolean
  end
end
