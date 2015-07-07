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

  def cost=(value)
    value.gsub(/[^0-9,\.]/, '').to_f
    write_attribute(:cost, value)
  end

  def total_raised
    donations.sum(:amount)
  end

  def funded?
  end
    
end

Family.import
Family.__elasticsearch__.create_index! force: true
