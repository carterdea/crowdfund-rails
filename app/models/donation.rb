# == Schema Information
#
# Table name: donations
#
#  id                   :integer          not null, primary key
#  amount               :decimal(15, 2)   default(0.0)
#  recurring            :boolean
#  at_tip               :integer          default(0)
#  family_email_updates :string           default("t")
#  message              :text
#  name                 :string
#  email                :string
#  at_newsletter        :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  hide_amount          :boolean
#  anonymous            :boolean
#  stripe_id            :string
#  token                :string
#  recipient_id         :integer
#  recipient_type       :string
#

class Donation < ActiveRecord::Base
  has_secure_token
  belongs_to :recipient, polymorphic: true, counter_cache: true, touch: true

  delegate :full_name, to: :recipient

  require 'stripe'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, format: VALID_EMAIL_REGEX
  validates :amount, numericality: { greater_than_or_equal_to: 1, message: 'Must be at least $1.' }
  validates :at_tip, numericality: true, allow_nil: true

  attr_accessor :stripe_token, :stripe_customer_id

  DONATION_AMOUNTS = [
    30, 50, 100, 500, 1000
  ]

  TIP_AMOUNTS = [
    [0, 'None'], [10, '10%'], [20, '20%']
  ]

  def donor_name
    if anonymous
      'Anonymous'
    else
      name
    end
  end

  def donation_amount
    if hide_amount
      'an undisclosed amount'
    else
      '$' + (amount.to_i).to_s
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
    if recurring
      'Monthly Donation'
    else
      'One-Time Donation'
    end
  end

  def stripe_charge_description
    "#{name}'s donation to #{full_name}"
  end

  def stripe_customer_description
    "#{name}'s (#{email}) monthly donation to #{full_name}"
  end

  def self.average_donation_amount
    Rails.cache.fetch('average_donation_amount', expires_in: 12.hours) do
      if Donation.any?
        Donation.average(:amount)
      else
        0
      end
    end
  end

  # Single Donations

  def create_stripe_charge
    if valid?
      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          amount: total_amount_in_cents, # amount in cents, again
          currency: 'usd',
          source: stripe_token,
          description: stripe_charge_description,
          receipt_email: email
        )
      rescue Stripe::CardError => e
        # The card has been declined
      end
    end
  end

  # Customers

  def charge_stripe_customer
    Stripe::Charge.create(
      amount: total_amount_in_cents, # in cents
      currency: 'usd',
      customer: stripe_id
    )
  end

  def delete_stripe_customer
    customer = Stripe::Customer.retrieve(self.stripe_id)
    customer.delete
  end

  # Subscriptions (Stripe Recurring)

  def subscribe_stripe_customer
    if valid?
      customer = Stripe::Customer.create(
        source: stripe_token,
        plan: 'monthly-gift-test', # this is a monthly plan w/ 1¢
        email: email,
        quantity: total_amount_in_cents,
        description: stripe_customer_description
      )
      save_customer_id(customer)
    end
  end

  def save_customer_id(customer)
    self.stripe_id = customer.id
  end

  def self.to_csv(options = { headers: true })
    CSV.generate(options) do |csv|
      attributes = %w(id amount recurring at_tip recipient_id recipient_type message name email anonymous hide_amount  stripe_id recipient_id recipient_type created_at updated_at)
      csv << attributes
      all.each do |family|
        csv << attributes.map { |attr| family.send(attr) }
      end
    end
  end
end

