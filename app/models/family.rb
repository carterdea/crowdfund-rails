require 'elasticsearch/model'

class Family < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  mount_uploader :photo, ImageUploader

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :first_name, :last_name, :postal_code, :cost, :description, presence: true

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
end

Family.import
