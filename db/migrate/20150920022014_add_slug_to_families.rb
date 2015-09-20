class AddSlugToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :slug, :string
    add_index :families, :slug
  end
end
