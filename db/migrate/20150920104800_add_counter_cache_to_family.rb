class AddCounterCacheToFamily < ActiveRecord::Migration
  def change
    add_column :families, :donations_count, :integer, null: false, default: 0
    add_column :families, :updates_count, :integer, null: false, default: 0
    add_column :families, :grants_count, :integer, null: false, default: 0
    Family.reset_column_information
    Family.all.each do |f|
      Family.update_counters f.id, tasks_count: f.tasks.length
    end
  end
end
