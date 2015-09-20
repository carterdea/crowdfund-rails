class AddCounterCacheToFamily < ActiveRecord::Migration
  def up
    add_column :families, :donations_count, :integer, default: 0
    add_column :families, :updates_count, :integer, default: 0
    add_column :families, :grants_count, :integer, default: 0
    Family.reset_column_information
    Family.all.each do |f|
      Family.update_counters f.id, tasks_count: f.tasks.length
    end
  end

  def down
    delete_column :families, :donations_count
    delete_column :families, :updates_count
    delete_column :families, :grants_count
  end
end
