class ChangeFamilyIdToRecipientIdInDonations < ActiveRecord::Migration
  def up
    remove_reference(:donations, :family, index: true, foreign_key: true)
    change_table :donations do |t|
      t.references :recipient, polymorphic: true, index: true
    end
  end

  def down
    remove_reference(:donations, :recipient, index: true, foreign_key: true)
    change_table :donations do |t|
      t.references :families, index: true, foreign_key: true
    end
  end
end
