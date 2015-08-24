class AddTokenToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :token, :string
  end
end
