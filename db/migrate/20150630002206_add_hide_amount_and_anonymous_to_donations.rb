class AddHideAmountAndAnonymousToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :hide_amount, :boolean
    add_column :donations, :anonymous, :boolean
    rename_column :donations, :newsletter, :at_newsletter
    rename_column :donations, :privacy, :family_email_updates
    add_index :donations, :family_email_updates
  end
end
