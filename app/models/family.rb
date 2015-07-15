require 'elasticsearch/model'

class Family < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader
  has_many :donations

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :first_name, :last_name, :postal_code, :cost, :description, presence: true
  validates :cost, numericality: true

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


  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def total_raised
    donations.sum(:amount)
  end

  def funded?
  end

  def country_name
    Country["#{self.country}"].name
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
    
end

Family.import
Family.__elasticsearch__.create_index! force: true
