class AddColumnsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :created_by, :string
    add_column :pages, :seo_title, :string
    add_column :pages, :seo_description, :string
    add_column :pages, :live, :boolean, default: false
    add_index :pages, :slug
  end
end
