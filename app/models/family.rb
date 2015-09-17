require 'elasticsearch/model'
require 'file_size_validator'

# app/models/family.rb
class Family < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # has_many :donations, as: :recipient
  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader
  has_many :donations, as: :recipient, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :grants, dependent: :destroy

  scope :approved, -> { where(approved: true).order('created_at DESC') }
  scope :unapproved, -> { where approved: false }

  validates :first_name, :last_name, :postal_code, :user_cost, :cost, presence: true
  validates :photo, presence: true, file_size: { maximum: 2.megabytes.to_i }
  validates_length_of :description, maximum: 2000, message: 'Please keep your story to less than 2,000 characters.'
  validates :cost, numericality: { less_than: 1_000_000 }
  validates :country, presence: true, length: { is: 2 }
  validates :quantity, numericality: { greater_than: 0 }
  validates_associated :user

  ADOPTION_STATUSES = [
    'Paperwork Not Started',
    'Paperwork Filed',
    'Homestudy Scheduled',
    'Homestudy Completed',
    'Awaiting Matching',
    'Matched',
    'Completed'
  ]

  def full_name
    "#{first_name} #{last_name}"
  end

  # Using a virtual attribute (user cost for cost) to clean up the user input
  def user_cost
    cost if cost
  end

  def user_cost=(cost)
    self.cost = cost.delete('$,') if cost.present?
  end

  def total_raised
    donations.sum(:amount)
  end

  def funded?
  end

  def country_name
    Country["#{country}"].name
  end

  def pluralize_is
    if first_name.include?(' ' || 'and' || '&')
      'are'
    else
      'is'
    end
  end

  def number_of_children
    if quantity > 1
      "#{quantity} children"
    else
      'a child'
    end
  end

  def donations_chart_data(start = 1.weeks.ago)
    total_amount_donated = amount_raised_by_day(start)
    (start.to_date..Date.today).map do |date|
      {
        date: date,
        amount: total_amount_donated[date] || 0,
      }
    end
  end

  def amount_raised_by_day(start)
    donations = self.donations.where(created_at: start.beginning_of_day..Time.zone.now)
    donations = donations.group("date(created_at)")
    donations = donations.select("date(created_at), sum(amount) as total_amount")
    donations.each_with_object({}) do |donation, amount|
      amount[donation.created_at.to_date] = donation.total_amount
    end
  end
end

Family.__elasticsearch__.create_index! force: true
Family.import
Family.__elasticsearch__.refresh_index!
