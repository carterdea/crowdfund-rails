class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.references :family, index: true, foreign_key: true
      t.string :title
      t.text :message
      t.boolean :on_profile
      t.boolean :email_donors

      t.timestamps null: false
    end
  end
end
