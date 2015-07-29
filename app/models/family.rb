require 'elasticsearch/model'

class Family < ActiveRecord::Base
  # has_many :donations, as: :recipient
  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader
  has_many :donations
  has_many :updates

  default_scope {order('created_at DESC')}

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :first_name, :last_name, :user_cost, :cost, :description, presence: true
  validates :cost, numericality: {less_than: 1000000}
  validates :country, presence: true, length: {is: 2}
  validates :quantity, numericality: {greater_than: 0}
  validates_format_of :photo, :with => %r{\.(png|jpg|jpeg)$}i, message: "The Photo must be a gif, jpg, or png image."

  GENDER_OPTIONS = [
    'Male',
    'Female',
    'Either'
  ]
  
  ADOPTION_STATUSES = [
    'Paperwork Not Started',
    'Paperwork Filed',
    'Homestudy Scheduled',
    'Homestudy Completed',
    'Awaiting Matching',
    'Matched',
    'Completed'
  ]

  # Using a virtual attribute (user cost for cost) to clean up the user input
  def user_cost
    cost
  end

  def user_cost=(cost)
    self.cost = cost.gsub(',', '') if cost.present?
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
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
    if first_name.include?(" " || "and" || "&")
      "are"
    else
      'is'
    end
  end

  def number_of_children
    if quantity > 1
      "#{quantity} children"
    else
      "a child"
    end
  end

  def toggle_approval
    toggle!(:approved)
  end
end

Family.import
Family.__elasticsearch__.create_index! force: true
