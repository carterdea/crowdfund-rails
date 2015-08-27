class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.references :family, index: true, foreign_key: true
      t.decimal :amount_requested
      t.text :expense_description
      t.string :supporting_documentation
      t.string :requested_to_name
      t.string :requested_to_address
      t.string :requested_to_city
      t.string :requested_to_state
      t.string :requested_to_zip
      t.boolean :signature
      t.string :status

      t.timestamps null: false
    end
  end
end
