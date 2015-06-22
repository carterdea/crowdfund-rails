class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :postal_code
      t.string :city
      t.string :state
      t.integer :cost
      t.string :country
      t.string :gender
      t.integer :quantity
      t.text :description
      t.string :status
      t.string :agency_name
      t.string :agency_site
      t.string :photo
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end
