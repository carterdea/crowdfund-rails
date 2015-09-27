# app/models/charity.rb
class Charity < ActiveRecord::Base
  has_many :donations, as: :recipient, dependent: :destroy

  def full_name
    'AdoptTogether'
  end

  def first_name
    'AdoptTogether Team'
  end

  def total_raised
    donations.map(&:amount).inject(:+)
  end
end
