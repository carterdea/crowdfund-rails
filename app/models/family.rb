require 'elasticsearch/model'
# app/models/family.rb
class Family < ActiveRecord::Base
  # has_many :donations, as: :recipient
  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader
  has_many :donations, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :grants, dependent: :destroy

  scope :approved, -> { where(approved: true).order('created_at DESC') }
  scope :unapproved, -> { where approved: false }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :first_name, :last_name, :postal_code, :user_cost, :cost, :photo, presence: true
  validates_length_of :description, maximum: 2000, message: 'Please keep your story to less than 2,000 characters.'
  validates :cost, numericality: { less_than: 1_000_000 }
  validates :country, presence: true, length: { is: 2 }
  validates :quantity, numericality: { greater_than: 0 }

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
    donations.pluck(:amount).sum
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
end

Family.import
Family.__elasticsearch__.create_index! force: true
