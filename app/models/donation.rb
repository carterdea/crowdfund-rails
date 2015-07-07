class Donation < ActiveRecord::Base
  belongs_to :family, dependent: :destroy
  # before_save :populate_uuid

  require 'stripe'

  validates :name, presence: true
  validates :email, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to: 100, message: "Must be at least $1."
  # validates_uniqueness_of :uuid

  attr_accessor :stripe_customer_id, :stripe_subscription_id, :stripe_token

  DONATION_AMOUNTS = [
    30, 50, 100, 500, 1000
  ]

  TIP_AMOUNTS = [
    0, 10, 20
  ]

def donor_name
  if self.anonymous.false?
    self.name
  else
    "Anonymous"
  end
end

def stripe_description
  "AdoptTogether Donation"
end

def create_stripe_charge
end

def create_stripe_subcsription
end

def update_stripe_customer_id
end

def send_receipt
end

def stripe_subscription
end

def populate_uuid
  if new_record?
    while !valid? || self.uuid.nil?
      self.uuid = SecureRandom.hex(1_000_000_000).to_s(36)
    end
  end
end

end
