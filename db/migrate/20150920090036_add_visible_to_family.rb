class AddVisibleToFamily < ActiveRecord::Migration
  def change
    add_column :families, :visible, :boolean, default: true
  end
end
