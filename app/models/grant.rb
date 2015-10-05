class Grant < ActiveRecord::Base
  belongs_to :family, counter_cache: true

  mount_uploader :supporting_documentation, AttachmentUploader

  validates :user_amount_requested, :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, presence: true
  # validates :supporting_documentation

  scope :approved, -> { where(status: 'approved') }

  def user_amount_requested
    amount_requested if amount_requested
  end

  def user_amount_requested=(amount_requested)
    self.amount_requested = amount_requested.delete('$,') if amount_requested.present?
  end

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  def self.to_csv(options = { headers: true })
    CSV.generate(options) do |csv|
      attributes = %w(id family_id amount_requested expense_description supporting_documentation requested_to_name requested_to_address requested_to_city requested_to_state requested_to_state requested_to_zip signature status created_at updated_at amount_approved)
      csv << attributes
      all.each do |family|
        csv << attributes.map { |attr| family.send(attr) }
      end
    end
  end
end
