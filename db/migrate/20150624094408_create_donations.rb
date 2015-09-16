class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :family, index: true, foreign_key: true
      t.integer :amount, index: true, default: 0.0
      t.boolean :recurring
      t.integer :at_tip, default: 0.0
      t.string :privacy
      t.text :message
      t.string :name
      t.string :email
      t.boolean :newsletter

      t.timestamps null: false
    end
  end
end
