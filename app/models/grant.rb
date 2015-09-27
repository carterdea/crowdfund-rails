class Grant < ActiveRecord::Base
  belongs_to :family, counter_cache: true

  mount_uploader :supporting_documentation, AttachmentUploader

  validates :user_amount_requested, :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, presence: true
  # validates :supporting_documentation

  def user_amount_requested
    amount_requested if amount_requested
  end

  def user_amount_requested=(amount_requested)
    self.amount_requested = amount_requested.delete('$,') if amount_requested.present?
  end

  def date_created
    created_at.strftime('%B %e, %Y')
  end
end
