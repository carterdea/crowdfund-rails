class AddCounterCacheToCharities < ActiveRecord::Migration
  def up
    add_column :charities, :donations_count, :integer, default: 0
  end

  def down
    delete_column :charities, :donations_count
  end
end
