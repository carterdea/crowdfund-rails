class AddAmountApprovedToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :amount_approved, :decimal
  end
end
