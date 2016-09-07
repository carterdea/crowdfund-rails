# == Schema Information
#
# Table name: charities
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  donations_count :integer          default(0)
#

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
