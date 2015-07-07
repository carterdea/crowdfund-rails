class AddStripeIdAndUuidToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_id, :string
    add_column :donations, :uuid, :string
  end
end
