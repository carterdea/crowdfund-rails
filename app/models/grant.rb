class Grant < ActiveRecord::Base
  belongs_to :family, counter_cache: true

  validates :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, presence: true
  # validates :supporting_documentation
end
