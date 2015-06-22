class Family < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name, :postal_code, :cost, :description, presence: true

  GENDER_OPTIONS = ['male', 'female', 'either']
  ADOPTION_STATUSES = ['paperwork not started', 'paperwork filed', 'homestudy scheduled', 'homestudy completed', 'awaiting matching', 'matched', 'completed']

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
