class AddHomeStudyFileToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :home_study_file, :string
  end
end
