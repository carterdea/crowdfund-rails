class Grant < ActiveRecord::Base
  belongs_to :family

  validates :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, :signature, presence: true
  # validates :supporting_documentation
end
