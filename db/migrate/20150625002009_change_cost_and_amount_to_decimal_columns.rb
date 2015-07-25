class ChangeCostAndAmountToDecimalColumns < ActiveRecord::Migration
  def up
    change_column :families, :cost, :decimal, :precision => 15, :scale => 2, :default => 0.00
    change_column :donations, :amount, :decimal, :precision => 15, :scale => 2, :default => 0.00
  end
  def down
    change_column :families, :cost, :integer
    change_column :donations, :amount, :integer
  end
end
