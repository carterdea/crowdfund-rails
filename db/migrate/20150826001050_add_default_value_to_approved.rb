class AddDefaultValueToApproved < ActiveRecord::Migration
  def up
    change_column :families, :approved, :boolean, :default => true
  end

  def down
    change_column :families, :approved, :boolean, :default => nil
  end
end
