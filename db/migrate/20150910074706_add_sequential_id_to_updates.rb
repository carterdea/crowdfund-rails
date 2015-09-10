class AddSequentialIdToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :sequential_id, :integer
  end
end
