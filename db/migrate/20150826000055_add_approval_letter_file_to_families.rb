class AddApprovalLetterFileToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :approval_letter_file, :string
  end
end
