class RemoveUuidFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :uuid, :string
    change_column_default :donations, :family_email_updates, true
  end
end
