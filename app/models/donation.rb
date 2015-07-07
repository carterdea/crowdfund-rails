class Donation < ActiveRecord::Base
  belongs_to :family, dependent: :destroy
  # before_save :populate_uuid

  require 'stripe'

  validates :name, presence: true
  validates :email, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to: 100, message: "Must be at least $1."
  # validates_uniqueness_of :uuid

  attr_accessor :stripe_token

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

  def tip_total
    tip_percent = at_tip / 100
    amount * tip_percent
  end

  def total_amount_in_cents
    amount += tip_total
    amount.to_i * 100
  end

  def stripe_description
    "AdoptTogether Donation"
  end

  def create_stripe_charge
    if valid?
      # Get the credit card details submitted by the form
      token = self.stripe_token

      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => total_amount_in_cents, # amount in cents, again
          :currency => "usd",
          :source => token,
          :description => stripe_description
        )
      rescue Stripe::CardError => e
        # The card has been declined
      end
    end
  end

  def create_stripe_subcsription
  end

  def update_stripe_customer_id
  end

  def send_receipt
  end

  def stripe_subscription
  end

end
