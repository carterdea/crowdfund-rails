require 'elasticsearch/model'
require 'file_size_validator'

# app/models/family.rb
class Family < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader
  has_many :donations, as: :recipient, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :grants, dependent: :destroy

  scope :approved, -> { where(approved: true).order('created_at DESC') }
  scope :unapproved, -> { where approved: false }

  scope :visible, -> { where(visible: true).order('created_at DESC') }
  scope :hidden, -> { where(visible: false) }

  before_validation :generate_slug

  EXCLUDED_SLUGS = %w(
    register
    signup
    login
    signin
    about
    reset_password
    resetpassword
    passwordreset
    adopttogether
    adopt_together
    adoption
    cancel
  )

  validates :first_name, :last_name, :postal_code, :user_cost, :cost, presence: true
  validates :photo, presence: true, file_size: { maximum: 2.megabytes.to_i }
  validates_length_of :description, maximum: 2000, message: 'Please keep your story to less than 2,000 characters.'
  validates :cost, numericality: { less_than: 1_000_000 }
  validates :country, presence: true, length: { is: 2 }
  validates :quantity, numericality: { greater_than: 0 }
  validates :slug, uniqueness: true, presence: true, exclusion: { in: EXCLUDED_SLUGS }
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

  def to_param
    slug
  end

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

  def total_amount_donated_until(date)
    donations.where("date(created_at) <= ?", date).sum(:amount)
  end

  def donations_chart_data(start = 1.weeks.ago)
    (start.to_date.prev_day..Date.tomorrow).map do |date|
      {
        date: date.to_s,
        amount: total_amount_donated_until(date)
      }
    end
  end

  private

  def generate_slug
    self.slug ||= "the-#{last_name.pluralize.parameterize}"
  end
end

Family.__elasticsearch__.create_index! force: true
Family.import
Family.__elasticsearch__.refresh_index!
