class AddStripeCustomerToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_customer, :string
  end
end
