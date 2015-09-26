class AddDefaultValueToGrants < ActiveRecord::Migration
  def up
    change_column :grants, :status, :string, default: 'requested'
  end

  def down
    change_column :grants, :status, :string, default: nil
  end
end
