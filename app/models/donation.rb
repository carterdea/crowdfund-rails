class Donation < ActiveRecord::Base
  belongs_to :family, dependent: :destroy
  # before_save :populate_uuid

  require 'stripe'

  validates :name, presence: true
  validates :email, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 1, message: "Must be at least $1."}
  validates :at_tip, numericality: true
  # validates_uniqueness_of :uuid

  attr_accessor :stripe_token

  DONATION_AMOUNTS = [
    30, 50, 100, 500, 1000
  ]

  TIP_AMOUNTS = [
    0, 10, 20
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
    amount.to_f * (at_tip.to_f / 100)
  end

  def total_amount_in_cents
    (amount + tip_total).to_i * 100
  end

  def stripe_charge_description
    "#{name}'s donation to #{family.full_name}"
  end

  def stripe_customer_description
    "#{name}'s (#{email}) recurring donation to #{family.full_name}"
  end

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

  def create_stripe_customer
    if valid?
      # Create a Customer
      customer = Stripe::Customer.create(
        :source => stripe_token,
        :description => stripe_customer_description
      )

      # Save the customer ID in your database so you can use it later
      save_stripe_customer_id(stripe_customer, customer.id)
    end
  end

  def charge_stripe_customer
    customer_id = get_stripe_customer_id(stripe_customer)

    Stripe::Charge.create(
      :amount   => total_amount_in_cents, # in cents
      :currency => "usd",
      :customer => customer_id
    )
  end

  def delete_stripe_customer
    customer = get_stripe_customer_id(stripe_customer)
    customer.delete
  end

  def send_receipt
  end
end
