class Donation < ActiveRecord::Base
  belongs_to :family
  # belongs_to :recipient
  # before_save :populate_uuid

  require 'stripe'
  require 'mandrill'

  validates :name, presence: true
  validates :email, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 1, message: "Must be at least $1."}
  validates :at_tip, numericality: true
  # validates_uniqueness_of :uuid

  attr_accessor :stripe_token, :stripe_customer_id

  DONATION_AMOUNTS = [
    30, 50, 100, 500, 1000
  ]

  TIP_AMOUNTS = [
    [0, "None"], [10, "10%"], [20, "20%"]
  ]

  def donor_name
    if anonymous == false
      name
    else
      "Anonymous"
    end
  end

  def donation_amount
    if hide_amount == false
      "$" + (amount.to_i).to_s
    else
      "an undisclosed amount"
    end
  end

  def tip_total
    at_tip
  end

  def total_amount_in_dollars
    (amount + tip_total).to_i
  end

  def total_amount_in_cents
    (amount + tip_total).to_i * 100
  end

  def type
    if recurring == false
      "Donation"
    else
      "Monthly Donation"
    end
  end

  def stripe_charge_description
    "#{name}'s donation to #{family.full_name}"
  end

  def stripe_customer_description
    "#{name}'s (#{email}) recurring donation to #{family.full_name}"
  end

  # Single Donations

  def create_stripe_charge
    if valid?
      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => total_amount_in_cents, # amount in cents, again
          :currency => "usd",
          :source => stripe_token,
          :description => stripe_charge_description,
          :receipt_email => email
        )
      rescue Stripe::CardError => e
        # The card has been declined
      end
    end
  end

  # Customers

  def charge_stripe_customer
    Stripe::Charge.create(
      :amount   => total_amount_in_cents, # in cents
      :currency => "usd",
      :customer => stripe_id
    )
  end

  def delete_stripe_customer
    customer = self.stripe_id
    customer.delete
  end

  # Subscriptions (Stripe Recurring)

  def subscribe_stripe_customer
    if valid?
      customer = Stripe::Customer.create(
        :source => stripe_token,
        :plan => "monthly-gift-test", # this is a monthly plan w/ 1¢
        :email => email,
        :quantity => total_amount_in_cents,
        :description => stripe_customer_description
      )
      save_customer_id(customer)
    end
  end

  def delete_stripe_customer_subscription
    
  end

  def save_customer_id(customer)
    self.stripe_id = customer.id    
  end

private

  def send_receipt

  end
end
