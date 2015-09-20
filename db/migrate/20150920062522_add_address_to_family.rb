class AddAddressToFamily < ActiveRecord::Migration
  def change
    add_column :families, :address, :string
  end
end
